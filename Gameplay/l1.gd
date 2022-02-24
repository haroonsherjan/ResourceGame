extends Node2D
onready var player = get_node("PlayerBody")

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(player.position.y)
	if player.position.x > 960:
		get_tree().change_scene("res://Gameplay/l2.tscn")
	if player.position.y > 650:
		get_tree().change_scene("res://Gameplay/l1.tscn")
