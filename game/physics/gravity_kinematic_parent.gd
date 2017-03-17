extends Node

export(bool) var override_gravity_speed = false
export(bool) var override_gravity_vector = false

export(float) var gravity_speed
export(Vector3) var gravity_vector

var target

func _ready():
	#return
	target = get_parent()
	
	if not target extends KinematicBody:
		printerr("Parent must be a Kinematic Body (3D)")
	
	if not override_gravity_speed:	gravity_speed = Globals.get("physics/default_gravity")
	if not override_gravity_vector:	gravity_vector = Globals.get("physics/default_gravity_vector")
	
	set_fixed_process(true)

func _fixed_process(delta):
	if target.has_method("add_movement"):
		target.add_movement(gravity_vector * gravity_speed)
	else:
		target.move(gravity_vector * gravity_speed * delta)
