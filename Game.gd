extends Node

var current_match

func _ready():
	randomize()
	$Music.play()
	$Menu/Characterselection.connect("match_instantiated", self, "_on_match_instantiated")
	$Menu/PauseScreen/Content/N1/C1/Buttons/Cancel.connect("pressed", self, "_on_cancel_pressed")
	$Menu/PauseScreen/Content/N1/C1/Buttons/Restart.connect("pressed", self, "_on_restart_pressed")
	$Menu/Main/content/C1/buttons/quit.connect("pressed", self, "_on_quit_pressed")

func _on_match_instantiated(new_match):
	current_match = new_match
	new_match.connect("match_finished", self, "_on_match_finished")
	add_child(new_match)
	$Music.stop()

func _on_match_finished(finished_match):
	current_match.queue_free()
	$Menu.visible = true
	$Music.play()

func _on_Music_finished():
	$Music.play()

func _on_cancel_pressed():
	current_match.queue_free()
	$Music.play()

func _on_restart_pressed():
	current_match.restart()

func _on_quit_pressed():
	get_tree().quit()
