extends Node

export(float, 1.0, 200.0, 0.5) var min_height = 5.0
export(float, 1.0, 200.0, 0.5) var max_height = 50.0

export(String) var jump_action_name = "jump"
export(float, 0.5, 5.0, 0.1) var time_to_max = 1.5

var character

var jumping = false
var jump_force

func _ready():
	character = get_node("../../KinematicBody")
	assert(character extends KinematicBody)
	
	jump_force = 500.0
	
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_pressed(jump_action_name):
		if not jumping and is_grounded():
			character.add_movement(Vector3(0, jump_force, 0))

func is_grounded():
	return get_node("../ground_check").is_colliding()
