extends "res://logic/FSM/FSMState.gd"

func on_enter():
	set_process_unhandled_input(true)
	.on_enter()

func _unhandled_input(e):
	if e.is_action_pressed("jump"):
		fsm.make_transition("jump")

func on_falling():
	fsm.make_transition("fall")

func on_exit():
	set_process_input(false)
	.on_exit()
