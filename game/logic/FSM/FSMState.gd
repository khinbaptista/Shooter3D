##################################################

extends Node

##################################################

var name
var fsm setget ,get_fsm

var transitions = {}
var active setget ,is_active

signal enter
signal exit

##################################################

func _ready():
	name = get_name()
	fsm = get_fsm()

func get_fsm():
	if fsm != null:
		return fsm
	
	var FSM = preload("FSM.gd")
	var parent = get_parent()
	
	if parent extends FSM:
		fsm = parent
		return fsm
	
	if parent.has_method("get_fsm"):
		fsm = parent.get_fsm()
		return fsm

func on_enter():
	active = true
	emit_signal("enter")

func on_exit():
	active = false
	emit_signal("exit")

func is_active():
	return active

##################################################

func add_transition(key, destination):
	if not transitions.has(key):
		transitions[key] = destination

func add_transition_nodepath(key, destination_path):
	if not transitions.has(key) and has_node(destination_path):
		transitions[key] = get_node(destination_path)

func transition_destination(key):
	if transitions.has(key):
		return transitions[key]
	return null

##################################################

func get_actual_state():
	return self

##################################################
