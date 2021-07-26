extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var window = OS.window_size
var paused = false
var pointer = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("ui_cancel"):	
		OS.window_fullscreen = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
