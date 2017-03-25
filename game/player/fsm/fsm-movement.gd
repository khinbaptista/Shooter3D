extends "res://logic/FSM/FSM.gd"

func _ready():
	#._ready()
	
	add_transition_path("move", "idle", "move")
	add_transition_path("idle", "move", "idle")
	
	add_transition_path("fall", "idle", "fall")
	add_transition_path("fall", "move", "fall")
	add_transition_path("idle", "fall", "idle")
	
	add_transition_path("jump", "idle", "jump")
	add_transition_path("jump", "move", "jump")
	add_transition_path("fall", "jump", "fall")
	
	set_current_state_name("idle")
