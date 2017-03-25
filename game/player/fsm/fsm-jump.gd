extends "res://logic/FSM/FSM.gd"

func _ready():
	add_transition_path("jump", "grounded", "jump")
	add_transition_path("fall", "jump", "fall")
	add_transition_path("fall", "grounded", "fall")
	add_transition_path("land", "fall", "grounded")
	
	set_current_state_name("grounded")
