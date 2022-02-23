extends RigidBody2D

onready var mini_body = preload("res://Gameplay/Player/RigidPlayer/MiniPlayer/MiniPlayer.tscn")
onready var min_scale = scale*0.3
onready var min_mass = mass*0.75
onready var curr_scale = scale
onready var curr_mass = mass
enum {
	IDLE,
	RUN,
	AIR
}

onready var just_aired_timer : Timer = $JustAiredTimer
onready var _transitions: = {
	IDLE: [RUN, AIR],
	RUN: [IDLE, AIR],
	AIR: [IDLE],
}

const FLOOR_NORMAL := Vector2.UP
export var move_speed := 100
export var air_speed := 5
export var jump_force := 10000000

var _state: int = IDLE

var states_strings := {
	IDLE: "idle",
	RUN: "run",
	AIR: "air"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var is_on_ground := (
		state.get_contact_count() > 0 and 
		int(state.get_contact_collider_position(0).y) >= int(global_position.y)
	)
	
	var move_direction = get_move_direction()
	
	if Input.is_action_just_pressed("ui_space"):
		spawn_mini()
	elif Input.is_key_pressed(KEY_V):
		recombine() #do combine
	
	match _state:
		IDLE:
			if move_direction.x:
				change_state(RUN)
			elif is_on_ground and Input.is_action_pressed("ui_up"):
				apply_central_impulse(Vector2.UP * jump_force)
				change_state(AIR)
		
		RUN:
			if not move_direction.x:
				change_state(IDLE)
			elif state.get_contact_count() == 0:
				change_state(AIR)
			elif is_on_ground and Input.is_action_pressed("ui_up"):
				apply_central_impulse(Vector2.UP * jump_force)
				change_state(AIR)
			else:
				state.linear_velocity.x = move_direction.x * move_speed
		
		AIR:
			if move_direction.x:
				state.linear_velocity.x += move_direction.x * air_speed
			if is_on_ground and just_aired_timer.is_stopped():
				change_state(IDLE)

func change_state(target_state: int) -> void:
	if not target_state in _transitions[_state]:
		return
	_state = target_state
	enter_state()

func enter_state() -> void:
	match _state:
		IDLE:
			linear_velocity.x = 0
		AIR:
			just_aired_timer.start()
		_:
			return

func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)


func recombine():
	
	pass

func spawn_mini():
	curr_scale = curr_scale * 0.9
	curr_mass = curr_mass * 0.99
	if curr_scale<=min_scale:
		return
	scale = curr_scale
	mass = curr_mass
	get_node("Sprite").scale = curr_scale
	get_node("CollisionShape2D").scale = curr_scale
	var child = mini_body.instance()
	child.position = position
	child.scale = min_scale
	child.get_node("Sprite").scale = min_scale
	child.get_node("CollisionShape2D").scale = min_scale
	child.mass = min_mass
	get_parent().add_child(child)
