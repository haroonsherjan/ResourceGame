extends Node2D
var mus = preload("res://Audio/bgm.mp3")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func startMusic():
	$MusicPlayer.autoplay = true
	$MusicPlayer.bus = "Music"
	$MusicPlayer.volume_db = 0
	$MusicPlayer.stream = mus
	$MusicPlayer.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
