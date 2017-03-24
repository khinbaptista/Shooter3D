extends "FSMState.gd"

const FSMState = preload("FSMState.gd")

var initial_state

func _ready():
	var children = get_children()
	initial_state = null
	var i = 0
	
	while initial_state == null and i < children.size():
		if children[i] extends FSMState:
			initial_state = children[i]
		i += 1
	
	assert(initial_state != null)
	._ready()

func on_enter():
	initial_state.on_enter()

func on_exit():
	var active_state = get_active_state()
	
	assert(active_state != null)
	active_state.on_exit()

##################################################

func get_active_state():
	var children = get_children()
	var active_state = null
	var i = 0
	
	while active_state == null and i < children.size():
		if children[i] extends FSMState and children[i].active:
			active_state = children[i]
		i += 1
	
	return active_state

func get_actual_state():
	return get_active_state()

##################################################
	