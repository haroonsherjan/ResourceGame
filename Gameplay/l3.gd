extends Node2D
onready var opencheck = false
onready var plates = get_tree().get_nodes_in_group("plate")
onready var door = get_node("TileMap/wall")
onready var player = get_node("TileMap/PlayerBody")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(player.position.y)
	if player.position.y > 1250:
		get_tree().change_scene("res://Gameplay/l3.tscn")
	
	if opencheck:
		return
	
	
	for p in plates:
		if p.counter < 3:
			return
	
	door.open()
	opencheck = true
