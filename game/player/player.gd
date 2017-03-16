extends KinematicBody

var FORWARD
const UP = Vector3(0, 1, 0)

export(float, 0, 100, 0.1) var movement_speed
export(float, 0, 1080, 1.0) var angular_speed
export(float, 0.05, 300, 0.05) var mouse_div

func _ready():
	FORWARD = Vector3(0, 0, -1)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		var angle = (event.speed_x / mouse_div) * deg2rad(angular_speed)
		FORWARD = FORWARD.rotated(Vector3(0, 1, 0), angle * get_process_delta_time())
		FORWARD = FORWARD.normalized()
	
	if event.is_action_pressed("ui_up"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("ui_down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _fixed_process(delta):
	look_at(get_global_transform().origin + FORWARD, Vector3(0, 1, 0))
	var RIGHT = FORWARD.cross(UP)
	
	var movement = Vector3()
	if Input.is_action_pressed("move_forward"):
		movement += FORWARD
	if Input.is_action_pressed("move_backward"):
		movement -= FORWARD
	if Input.is_action_pressed("move_right"):
		movement += RIGHT
	if Input.is_action_pressed("move_left"):
		movement -= RIGHT

	if movement != Vector3():
		movement = movement.normalized() * movement_speed
		move(movement)

