extends Node

export(PackedScene) var match_template
export(PackedScene) var controll_template
export(int) var controll_count = 2


func _ready():
	randomize()
	
	$Music.play()
	
	for id in controll_count:
		var controll = controll_template.instance()
		$Controlls.add_child(controll)
		controll.setup(id)
	
	$Menu.controlls = $Controlls.get_children()
	$Menu.switch_controlls(0)

func start_match(identities):
	print(identities)
	var new_match = match_template.instance()
	new_match.player_identities = identities
	
	
	new_match.connect("match_finished", self, "_on_match_finished")
	new_match.connect("match_instanciated", $Menu, "tutorial")
	$Menu.connect("restart_requested", new_match, "reset")
	$Menu.connect("stop_requested", new_match, "stop")
	$Menu.connect("tutorial_exited", new_match, "start")
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

