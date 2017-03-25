extends Node

var gravity_acceleration = 9.8
export(Vector3) var gravity_vector = Vector3(0, -1, 0)

var character
var properties
var physics

func _ready():
	character = get_parent().get_parent()
	assert(character extends KinematicBody)
	
	properties = get_node("../../properties")
	physics = get_parent()
	
	#set_fixed_process(true)

func _fixed_process(delta):
	var accel = gravity_vector * gravity_acceleration * delta
	print("gravity acceleration = ", accel)
	physics.acceleration += accel
