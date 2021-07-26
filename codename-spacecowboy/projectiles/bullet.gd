extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var speed = 5
var rot = Globals.pointer

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = rot
	$"Timer".start()

func _physics_process(delta):
	$"bullet".position.x += speed
	if $"Timer".time_left < $"Timer".wait_time/10:
		$"bullet/Sprite".modulate.a -= .1



func _on_Timer_timeout():
	queue_free()
