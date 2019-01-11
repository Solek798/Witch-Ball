extends Control

enum mode {PLAYER_1 = 1, PLAYER_2 = 2}
const player_1_color = Color("0900ff")
const player_2_color = Color("ff0000")

var current_mode
var player_1_selection
var player_2_selection

signal match_instantiated(new_match)

# TEMP
export(PackedScene) var match_template
export(PackedScene) var scarlett
export(PackedScene) var jasmine

func _ready():
	current_mode = PLAYER_1
	$CenterContainer/VBoxContainer/Selection/Railing.modulate = player_1_color

func switch_player():
	current_mode = PLAYER_2
	$CenterContainer/VBoxContainer/Selection/Railing.modulate = player_2_color

func end_selection():
	current_mode = null
	$CenterContainer/VBoxContainer/Selection/Railing.modulate = Color("ffffff")
	$CenterContainer/VBoxContainer/Selection/Play.disabled = false

func _on_Scarlett_pressed():
	match current_mode:
		PLAYER_1:
			$CenterContainer/VBoxContainer/Characters/Scarlett/Selection.player_1 = true
			player_2_selection = scarlett
			switch_player()
		PLAYER_2:
			$CenterContainer/VBoxContainer/Characters/Scarlett/Selection.player_2 = true
			player_2_selection = scarlett
			end_selection()

func _on_Jasmine_pressed():
	match current_mode:
		PLAYER_1:
			$CenterContainer/VBoxContainer/Characters/Jasmine/Selection.player_1 = true
			player_1_selection = jasmine
			switch_player()
		PLAYER_2:
			$CenterContainer/VBoxContainer/Characters/Jasmine/Selection.player_2 = true
			player_2_selection = jasmine
			end_selection()

func _on_Play_pressed():
	var new_match = match_template.instance()
	new_match.player_1_selection = self.player_1_selection
	new_match.player_2_selection = self.player_2_selection
	emit_signal("match_instantiated", new_match)
	
	current_mode = PLAYER_1
	$CenterContainer/VBoxContainer/Characters/Scarlett/Selection.reset()
	$CenterContainer/VBoxContainer/Characters/Jasmine/Selection.reset()
