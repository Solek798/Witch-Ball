extends Node

export(PackedScene) var match_template
export(PackedScene) var controll_template
export(int) var controll_count = 2
export(Array, String, FILE, "*.tscn") var arenas


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
	Transition.on()
	yield(Transition, "done_on")
	
	var new_match = match_template.instance()
	new_match.player_identities = identities
	new_match.arena_template = load(arenas[randi() % arenas.size()])
	
	new_match.connect("match_finished", $Menu, "win_screen")
	new_match.connect("match_instanciated", $Menu, "tutorial")
	new_match.connect("match_reseted", Transition, "off")
	new_match.connect("tree_exited", self, "_on_match_tree_exited")
	$Menu.connect("restart_requested", new_match, "reset")
	$Menu.connect("stop_requested", new_match, "stop")
	$Menu.connect("intro_finished", new_match, "start")
	add_child_below_node($Music, new_match)
	
	$Music.stop()
	Transition.off()

func _on_match_tree_exited():
	Transition.off()
	$Music.play()
	$Menu.menu()

func _on_Game_tree_exiting():
	ProjectSettings.save()

