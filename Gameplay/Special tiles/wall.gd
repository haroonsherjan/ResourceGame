extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _process(delta):
	if Input.is_key_pressed(KEY_U):
		open()


func open():
	queue_free()
