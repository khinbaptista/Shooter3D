extends Node

export(float, 0, 1080, 1.0) var angular_speed
export(float, 0.05, 300, 0.05) var mouse_div

export(NodePath) var physics_path
onready var physics = get_node(physics_path)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		var angle = (event.speed_x / mouse_div) * deg2rad(angular_speed)
		physics.rotate_look(angle * get_process_delta_time())
		angle = (event.speed_y / mouse_div) * deg2rad(angular_speed)
		physics.rotate_look_updown(angle * get_process_delta_time())
		
	if event.is_action_pressed("ui_up"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("ui_down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
