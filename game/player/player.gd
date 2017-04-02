extends KinematicBody

export(NodePath) var camera_path
onready var camera = get_node(camera_path)

func get_forward():
	var offset = get_global_transform().origin - camera.get_global_transform().origin
	offset.y = 0.0
	
	return offset.normalized()
