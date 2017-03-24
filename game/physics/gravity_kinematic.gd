extends Node

export(float) var gravity_speed = 9.8
export(Vector3) var gravity_vector = Vector3(0, -1, 0)

var character
var properties

func _ready():
	character = get_parent().get_parent()
	assert(character extends KinematicBody)
	
	properties = get_node("../../properties")
	
	set_fixed_process(true)

func _fixed_process(delta):
	if character.has_method("add_movement"):
		character.add_movement(gravity_vector * gravity_speed * properties.weight)
	else:
		character.move(gravity_vector * gravity_speed * properties.weight * delta)
