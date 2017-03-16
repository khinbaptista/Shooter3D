extends Position3D

export(NodePath) var target_path
var target
var offset

export(float, 0, 360, 0.1) var angular_speed
export(float, 0.05, 50, 0.05) var mouse_deadzone
export(float, 0.1, 200, 0.1) var speed_scale

func _ready():
	target = get_node(target_path)
	offset = get_global_transform().origin - target.get_global_transform().origin
	
	#Input.set_mouse_mode(2)
	
	#set_process(true)
	#set_process_input(true)

func _process(delta):
	var transform = get_global_transform()
	transform.origin = target.get_global_transform().origin + offset
	
	set_global_transform(transform)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		var movement = Vector2()
		
		if event.speed_x > mouse_deadzone:
			movement += Vector2(event.speed_x / speed_scale, 0)
		if event.speed_x < -mouse_deadzone:
			movement += Vector2(event.speed_x / speed_scale, 0)
		#if event.relative_y > mouse_deadzone:
		#	movement += Vector2(0, event.relative_y / speed_scale)
		#if event.relative_y < -mouse_deadzone:
		#	movement += Vector2(0, event.relative_y / speed_scale)
		
		if movement != Vector2():
			rotate_camera(movement * angular_speed * get_process_delta_time())
			#Input.warp_mouse_pos(Vector2(200, 100))

func rotate_camera(movement):
	offset = offset.rotated(Vector3(0, 1, 0), deg2rad(movement.x))
	look_at(target.get_global_transform().origin, Vector3(0, 1, 0))
