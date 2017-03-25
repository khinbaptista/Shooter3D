extends "res://logic/FSM/FSMState.gd"

export(NodePath) var physics_path
export(NodePath) var properties_path
var physics
var properties

func _ready():
	physics = get_node(physics_path)
	properties = get_node(properties_path)

func on_enter():
	set_fixed_process(true)
	.on_enter()

func on_exit():
	set_fixed_process(false)
	.on_exit()

func _fixed_process(delta):
	var movement = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		movement.z -= 1.0
	if Input.is_action_pressed("move_backward"):
		movement.z += 1.0
	if Input.is_action_pressed("move_left"):
		movement.x -= 1.0
	if Input.is_action_pressed("move_right"):
		movement.x += 1.0
	
	if movement == Vector3():
		fsm.make_transition("idle")
		return
	
	physics.velocity_frame += movement.normalized() * properties.get_movement_speed()
