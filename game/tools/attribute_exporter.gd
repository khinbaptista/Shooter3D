tool
extends Node

var children

func _ready():
	children = get_children()
	
	for child in children:
		var properties = child.get_property_list()
		for property in properties:
			var pname = child.get_name() + "/" + property.name
			set(pname, property)
	