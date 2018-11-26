extends Node

export(PackedScene) var arena_template


func _ready():
	var arena = arena_template.instance()
	add_child(arena)
