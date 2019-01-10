extends Node


func _ready():
	randomize()
	$Menu.connect("match_instantiated", self, "_on_match_instantiated")
	$Music.play()

func _on_match_instantiated(new_match):
	new_match.connect("match_finished", self, "_on_match_finished")
	add_child(new_match)
	$Menu.visible = false
	$Music.stop()

func _on_match_finished(finished_match):
	finished_match.queue_free()
	$Menu.visible = true
	$Music.play()

func _on_Music_finished():
	$Music.play()
