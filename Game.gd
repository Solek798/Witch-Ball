extends Node

export(PackedScene) var match_template

var current_match


func _ready():
	randomize()
	$Music.play()
	$Menu.connect("requested_match_start", self, "_on_requested_match_start")

func _on_requested_match_start(selection):
	current_match = match_template.instance()
	current_match.connect("match_finished", self, "_on_match_finished")
	$Menu.connect("requested_match_restart", current_match, "_on_requested_match_restart")
	$Menu.connect("requested_match_canceled", current_match, "_on_requested_match_canceled")
	current_match.player_1_selection = selection[0]
	current_match.player_2_selection = selection[1]
	add_child(current_match)
	$Music.stop()
	$Menu.visible = false

func _on_match_finished(finished_match):
	current_match.queue_free()
	$Menu.visible = true
	$Music.play()

func _on_Music_finished():
	$Music.play()
