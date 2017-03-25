extends Area

func is_colliding():
	return get_overlapping_bodies().size() > 0