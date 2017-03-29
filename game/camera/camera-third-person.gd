extends Camera

export var capture_mouse = true setget set_capture_mouse
export var player_is_parent = true
export(NodePath) var player_path

export(float, 0.05, 1800, 0.05) var angular_speed = 40.0
export(float, 1, 5000, 1) var mouse_speed_factor = 200.0

var player

var offset
var forward	# forward vector

var height
var pitch	# lateral rotation

func _ready():
	if player_is_parent:	player = get_parent()
	else:			player = get_node(player_path)
	
	var transform	= get_global_transform()
	var p_transform	= player.get_global_transform()
	
	offset	= transform.origin - p_transform.origin
	height	= transform.origin.y - p_transform.origin.y
	pitch	= get_rotation_deg().x
	forward	= (transform.basis * Vector3(0, 0, -1)).normalized()
	#forward.y = 0
	
	set_process_input(true)

func _input(event):
	if event.type != InputEvent.MOUSE_MOTION: return
	
	var angle = (event.speed / mouse_speed_factor) * deg2rad(angular_speed)
	rotate_look(angle)

func rotate_look(rot_vector):
	var right_vector = forward.cross(Vector3(0, 1, 0))
	
	offset	= offset.rotated(Vector3(0, 1, 0), rot_vector.x)
	forward	= forward.rotated(Vector3(0, 1, 0), rot_vector.x)
	offset	= offset.rotated(right_vector, rot_vector.y)
	forward	= forward.rotated(right_vector, rot_vector.y)
	
	var pos = player.get_global_transform().origin + offset
	look_at_from_pos(pos, pos + forward, Vector3(0, 1, 0))

func set_capture_mouse(capture):
	capture_mouse = capture
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
