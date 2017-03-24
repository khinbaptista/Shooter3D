extends "res://logic/FSM/FSMState.gd"

export(StringArray) var move_actions

func on_enter():
	set_process_input(true)
	.on_enter()

func _input(e):
	for action in move_actions:
		if e.is_action_pressed(action):
			fsm.make_transition("move")
