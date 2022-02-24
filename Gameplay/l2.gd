extends Node2D
onready var player = get_node("PlayerBody")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	print(player.position.y)
	if player.position.x > 1440:
		get_tree().change_scene("res://Gameplay/l3.tscn")
	if player.position.y > 650:
				get_tree().change_scene("res://Gameplay/l2.tscn")
