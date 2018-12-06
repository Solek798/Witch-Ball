extends Node


func _ready():
	$Menu.connect("match_instantiated", self, "_on_match_instantiated")

func _on_match_instantiated(new_match):
	add_child(new_match)
	$Menu.visible = false