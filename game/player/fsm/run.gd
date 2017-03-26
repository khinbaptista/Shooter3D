extends "res://logic/FSM/FSMState.gd"

export(NodePath) var physics_path
export(NodePath) var properties_path
var physics
var properties

var last_movement = Vector3()

func _ready():
	physics = get_node(physics_path)
	properties = get_node(properties_path)

func on_enter():
	last_movement = Vector3()
	set_fixed_process(true)
	.on_enter()

func on_exit():
	physics.velocity_walk -= last_movement
	set_fixed_process(false)
	.on_exit()

func _fixed_process(delta):
	var movement = movement_input()
	
	if movement == Vector3():
		fsm.make_transition("idle")
		return
	
	movement = movement.normalized() * properties.get_movement_speed()
	physics.velocity_walk += movement - last_movement
	
	last_movement = movement

func movement_input():
	var forward	= physics.get_forward_vector()
	var right	= physics.get_right_vector()
	var movement	= Vector3()
	
	if Input.is_action_pressed("move_forward"):
		movement.z += 1.0
	if Input.is_action_pressed("move_backward"):
		movement.z -= 1.0
	if Input.is_action_pressed("move_left"):
		movement.x -= 1.0
	if Input.is_action_pressed("move_right"):
		movement.x += 1.0
	
	forward.y = 0; right.y = 0
	movement = forward.normalized() * movement.z + right.normalized() * movement.x
	
	return movement
