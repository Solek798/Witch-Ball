extends Node

# TEMP
export(PackedScene) var match_template


func _ready():
	var new_match = match_template.instance()
	add_child(new_match)
