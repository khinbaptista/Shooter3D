##################################################

extends Node

##################################################

var states = {}
var current_state setget set_current_state

const FSMState = preload("FSMState.gd")

##################################################

func _ready():
	var children = get_children()
	for child in children:
		# If the child node extends FSMState, add it to states
		if child extends FSMState: add_state(child)

##################################################

func add_state(state):
	if not state extends FSMState: return
	
	var name = state.get_name()
	assert(not states.has(name))
	
	states[name] = state
	#if states.size() == 1: set_current_state(state)

func add_transition(key, origin, destination):
	assert(origin extends FSMState)
	assert(destination extends FSMState)
	origin.add_transition(key, destination)

func add_transition_path(key, origin_name, destination_nodepath):
	assert(states.has(origin_name))
	assert(has_node(destination_nodepath))
	add_transition(key, states[origin_name], get_node(destination_nodepath))

##################################################

func set_current_state(next_state):
	next_state.on_enter()
	
	if current_state != null:
		current_state.on_exit()
	
	current_state = next_state.get_actual_state()

func set_current_state_name(state_name):
	assert(states.has(state_name))
	set_current_state(states[state_name])

func make_transition(key):
	var next_state = current_state.transition_destination(key)
	if next_state == null or next_state == current_state: return false
	
	set_current_state(next_state)
	prints("FSM key:", key)
	return true
	
##################################################
