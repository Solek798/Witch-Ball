extends Node


func _ready():
	$Menu.connect("match_instantiated", self, "_on_match_instantiated")

func _on_match_instantiated(new_match):
	new_match.connect("match_finished", self, "_on_match_finished")
	add_child(new_match)
	$Menu.visible = false

func _on_match_finished(finished_match):
	finished_match.queue_free()
	$Menu.visible = true