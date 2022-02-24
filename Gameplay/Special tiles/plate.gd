extends StaticBody2D

var counter = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Text.text = "0/3"
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Box_body_entered(body):
	counter = counter + 1
	if counter < 3:
		$Text.text = str(counter) + "/3"
	else:
		$Text.text = "3/3"


func _on_Box_body_exited(body):
	if counter > 0:
		counter -= 1
		$Text.text = str(counter) + "/3"
