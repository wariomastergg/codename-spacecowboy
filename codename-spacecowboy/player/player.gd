extends KinematicBody2D

var acceleration = 50
var max_speed = 300
var friction = 100

var velocity = Vector2()
var mouse = Vector2()

onready var gun_piv = $"gun_pivot"
onready var gun = $"gun_pivot/gun"
onready var bullet = load("res://projectiles/bullet.tscn")
func _ready():
	#set to middle
	#position.x = round(Globals.window.x/2)
	#position.y = round(Globals.window.y/2)
	pass
	
func _physics_process(delta):
	#take the inputs
	input(delta)
	#move the player
	move_and_collide(velocity)
	#move and shoot the gun
	gun_mov()
	
#point gun in direction
func gun_mov():
	mouse = lerp(mouse, get_global_mouse_position(), 0.3)
	gun_piv.look_at(mouse)
	if gun_piv.rotation_degrees > 360:
		gun_piv.rotation_degrees = 0
	if gun_piv.rotation_degrees < 0:
		gun_piv.rotation_degrees = 360
	if gun_piv.rotation_degrees > 90 and gun_piv.rotation_degrees < 270:
		gun.scale.y = -5
	else:
		gun.scale.y = 5
	Globals.pointer = gun_piv.rotation_degrees
	#shoot
	if Input.is_action_just_pressed("l_click"):
		var projectile = bullet.instance()
		get_owner().add_child(projectile)
		projectile.global_position = gun.global_position

#take the inputs
func input(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized()
	if input_vec != Vector2.ZERO:
		velocity += input_vec * acceleration * delta
		velocity = velocity.clamped(max_speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
