extends Camera

export var capture_mouse = true setget set_capture_mouse
export var player_is_parent = true
export(NodePath) var player_path

export(float, 0.05, 1800, 0.05) var angular_speed = 40.0
export(float, 1, 5000, 1) var mouse_speed_factor = 200.0

export(float, 0.0, 50.0, 0.5) var block_angle = 10.0

var player

var offset
var distance
var forward	# forward vector

var height
var pitch	# lateral rotation

func _ready():
	if player_is_parent:	player = get_parent()
	else:			player = get_node(player_path)
	
	var transform	= get_global_transform()
	var p_transform	= player.get_global_transform()
	
	offset	= transform.origin - p_transform.origin
	distance = offset.length()
	height	= transform.origin.y - p_transform.origin.y
	pitch	= get_rotation_deg().x
	forward	= (transform.basis * Vector3(0, 0, -1)).normalized()
	#forward.y = 0
	
	set_process_input(true)
	
	if not player_is_parent:
		set_fixed_process(true)

func _fixed_process(delta):
	var transform = get_global_transform()
	transform.origin = player.get_global_transform().origin + offset
	call_deferred("set_global_transform", transform)

func _input(event):
	if event.type != InputEvent.MOUSE_MOTION: return
	
	var angle = (event.speed / mouse_speed_factor) * deg2rad(angular_speed)
	rotate_look(angle)

func rotate_look(rot_vector):
	var right_vector = forward.cross(Vector3(0, 1, 0))
	
	# Safe rotation
	offset	= offset.rotated(Vector3(0, 1, 0), rot_vector.x)
	forward	= forward.rotated(Vector3(0, 1, 0), rot_vector.x)
	
	#Unsafe rotation
	var new_offset	= offset.rotated(right_vector, rot_vector.y)
	var new_forward	= forward.rotated(right_vector, rot_vector.y)
	
	var angle = new_offset.angle_to(Vector3(0, 1, 0))
	if angle >= deg2rad(block_angle) and angle <= deg2rad(160.0 - block_angle):
		# Test against '160 - block' based on tests; 180 didn't work
		offset  = new_offset
		forward	= new_forward
	
	var pos = player.get_global_transform().origin + (offset.normalized() * distance)
	look_at_from_pos(pos, pos + forward, Vector3(0, 1, 0))

func set_capture_mouse(capture):
	capture_mouse = capture
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
