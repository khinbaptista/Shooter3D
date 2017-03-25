extends Node

### Physics
export(float, 0, 5000, 0.1) var weight = 1

### Movement
export(float, 0.0, 200.0, 0.1) var movement_speed = 50.0 setget ,get_movement_speed

### Jump
export(float, 0.0, 2.0, 0.01) var air_control_modifier = 0.5
export(float, 0.5, 500.0, 0.5) var jump_min_height = 1.0
export(float, 0.5, 500.0, 0.5) var jump_max_height = 3.0
export(float, 0.5, 500.0, 0.5) var jump_max_distance = 5.0
export(float, 0.05, 5000.0, 0.05) var jump_max_ms = 1000.0

### Vars
onready var physics = get_parent().get_node("physics")

func get_max_movement_speed():
	return movement_speed

func get_movement_speed():
	if not physics.grounded():
		return movement_speed * air_control_modifier
	
	return movement_speed
