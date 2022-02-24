extends Node2D

onready var menu = get_node("Menu")
var game = preload("res://Gameplay/l1.tscn")
var musNode = preload("res://MainMenu/musicScene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	menu.connect("play_game", self, "start_game")

func start_game():
	remove_child(menu)
	var game_instance =  game.instance()
	add_child(game_instance)
	var mus = musNode.instance()
	mus.startMusic()
	get_tree().root.add_child(mus)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
