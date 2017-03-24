extends "res://logic/FSM/FSM.gd"

func _ready():
	#._ready()
	
	add_transition_path("move", "idle", "run")
	add_transition_path("idle", "run", "idle")
	
	set_current_state_name("idle")
