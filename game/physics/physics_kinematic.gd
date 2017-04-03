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
var velocity_walk	= Vector3()
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
	
	player.look_at(player.get_global_transform().origin + player.get_forward(), Vector3(0, 1, 0))
#	velocity_walk = Vector3()

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
		emit_signal("landed")
	elif was_grounded and not grounded:
		acceleration += gravity_vector
		emit_signal("not_grounded")

func apply_movement(delta):
	velocity += acceleration * delta
	
	var applied = (velocity_walk + velocity) * delta
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
	if fmod(timer, 3.0) <= 0.03:
		if player.is_colliding():
			print("applied velocity = ", applied + applied2)
		else:
			print("applied velocity = ", applied)

func rotate_look_leftright(deg):
	player.rotate_y(deg2rad(deg))
	player.look_at(player.get_global_transform().origin + get_forward_vector(), Vector3(0, 1, 0))

func rotate_look_updown(deg):
	player.rotate_x(deg2rad(deg))
	player.look_at(player.get_global_transform().origin + get_forward_vector(), Vector3(0, 1, 0))

func get_rotation_matrix():
	return player.get_global_transform().basis

func get_forward_vector():
	#return get_rotation_matrix() * Vector3(0, 0, -1)
	return player.get_forward()

func get_up_vector():
	return get_rotation_matrix() * Vector3(0, 1, 0)

func get_right_vector():
	return get_forward_vector().cross(get_up_vector())

func set_velocity_frame(vector):
	velocity_walk = vector
