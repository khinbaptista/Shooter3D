extends "res://logic/FSM/FSMState.gd"

export(NodePath) var properties_path
export(NodePath) var physics_path

onready var properties	= get_node(properties_path)
onready var physics	= get_node(physics_path)

############################################################
# "GDC: Building a better jump"
#	https://www.youtube.com/watch?v=hG9SzQxaCm8
############################################################

var height	# h
var velocity	# vx
var distance	# xh
var t_peak	# th

var initial_jump_velocity	# v0
var timer

func _ready():
	height	 = properties.jump_max_height
	distance = properties.jump_max_distance * 0.5
	velocity = properties.get_max_movement_speed()
	t_peak	 = distance / velocity
	
	initial_jump_velocity	= (2.0 * height * velocity) / distance
	
	var g = abs((-2.0 * height * pow(velocity, 2)) / pow(distance, 2))
	properties.physics.gravity_acceleration = g
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(t_peak)
	timer.set_autostart(false)
	timer.connect("timeout", self, "on_peak")
	add_child(timer)

func on_enter():
	properties.physics.velocity += Vector3(0, initial_jump_velocity, 0)
	timer.start()

func on_peak():
	fsm.make_transition("fall")
