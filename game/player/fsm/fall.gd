extends "res://logic/FSM/FSMState.gd"

export(NodePath) var physics_path
onready var physics = get_node(physics_path)

func on_enter():
	if physics.grounded():
		call_deferred("on_landed")
	
	.on_enter()

func on_landed():
	fsm.make_transition("idle")
