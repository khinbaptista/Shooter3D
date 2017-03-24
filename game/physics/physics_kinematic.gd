extends Node

var character

var grounded = false

signal landed
signal not_grounded

var movement = Vector3()

func _ready():
	character = get_parent()
	assert(character extends KinematicBody)
	
	set_fixed_process(true)

func _fixed_process(delta):
	update_grounded()
	apply_movement()

func grounded():
	return grounded

func update_grounded():
	var was_grounded = grounded
	grounded = get_node("ground_check").is_colliding()
	
	if not was_grounded and grounded:
		emit_signal("landed")
	elif was_grounded and not grounded:
		emit_signal("not_grounded")

func apply_movement():
	pass
