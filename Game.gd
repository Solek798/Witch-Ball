extends Node

export(PackedScene) var match_template


func _ready():
	randomize()
	$Music.play()
	
	#$Characterselection.connect("match_instantiated", self, "_on_match_instantiated")

func start_match(selection):
	var new_match = match_template.instance()
	new_match.player_1_selection = selection[0]
	new_match.player_2_selection = selection[1]
	
	new_match.connect("match_finished", self, "_on_match_finished")
	add_child(new_match)
	
	$Music.stop()

func _on_match_finished(finished_match):
	finished_match.queue_free()
	$Music.play()
	$Menu.menu()

func _on_Music_finished():
	$Music.play()
