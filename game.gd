extends Node

export(PackedScene) var match_template


func _ready():
	randomize()
	$Music.play()
	
	$Controlls1.setup(0)
	$Controlls2.setup(1)

func start_match(selection):
	var new_match = match_template.instance()
	new_match.player_1_selection = selection[0]
	new_match.player_2_selection = selection[1]
	
	
	new_match.connect("match_finished", self, "_on_match_finished")
	new_match.connect("match_instanciated", $Menu, "tutorial")
	$Menu.connect("restart_requested", new_match, "reset")
	$Menu.connect("stop_requested", new_match, "stop")
	$Menu.connect("tutorial_exited", new_match, "start", [[$Controlls1, $Controlls2]])
	add_child_below_node($Music, new_match)
	
	$Music.stop()

func _on_match_finished(finished_match):
	finished_match.queue_free()
	$Music.play()
	$Menu.menu()

func _on_Music_finished():
	$Music.play()

func _on_Game_tree_exiting():
	ProjectSettings.save()
