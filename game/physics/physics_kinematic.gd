extends Node

var player

var	grounded = true
signal	landed
signal	not_grounded

### Gravity
var gravity_acceleration = 9.8 setget set_gravity_acceleration
export(Vector3) var gravity_vector = Vector3(0, -1, 0)

### Motion (raw)
var acceleration	= Vector3()
var velocity		= Vector3()
var velocity_frame	= Vector3()
export(float) var max_speed = 30.0

var timer = 0

func _ready():
	player = get_parent()
	assert(player extends KinematicBody)
	
	gravity_vector = gravity_vector.normalized() * gravity_acceleration
	set_fixed_process(true)

func _fixed_process(delta):
	update_grounded()
	apply_movement(delta)
	
	if grounded: velocity_frame = Vector3()

func grounded():
	return grounded

func set_gravity_acceleration(accel):
	gravity_acceleration = accel
	gravity_vector = gravity_vector.normalized() * gravity_acceleration

func update_grounded():
	var was_grounded = grounded
	grounded = get_node("ground_check").is_colliding()
	
	if not was_grounded and grounded:
		acceleration -= gravity_vector
		velocity.y = 0.0
		print("landed")
		emit_signal("landed")
	elif was_grounded and not grounded:
		acceleration += gravity_vector
		print("not grounded")
		emit_signal("not_grounded")

func apply_movement(delta):
	velocity += acceleration * delta
	
	var applied = (velocity_frame + velocity) * delta
	if applied.length() > max_speed: applied = applied.normalized() * max_speed
	
	var slide = player.move(applied)
	var applied2 = Vector3()
	
	if player.is_colliding():
		var n = player.get_collision_normal()
		applied2 = slide.slide(n)
		velocity = slide.slide(n)
		
		player.move(applied2)

	return

	timer += delta;
	if fmod(timer, 5.0) <= 0.05:
		if player.is_colliding():
			print("applied velocity = ", applied + applied2)
		else:
			print("applied velocity = ", applied)
