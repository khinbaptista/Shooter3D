extends "res://logic/FSM/FSMState.gd"

export(StringArray) var move_actions

func on_enter():
	set_fixed_process(true)
	.on_enter()

func _fixed_process(delta):
	for action in move_actions:
		if Input.is_action_pressed(action):
			fsm.make_transition("move")
			return
