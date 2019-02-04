extends Control

enum mode {PLAYER_1 = 1, PLAYER_2 = 2}
const player_1_color = Color("0900ff")
const player_2_color = Color("ff0000")

var current_mode
var player_1_selection
var player_2_selection

signal match_instantiated(new_match)

# TEMP
export(PackedScene) var scarlett
export(PackedScene) var jasmine
export(PackedScene) var lilith

func _ready():
	current_mode = PLAYER_1
	$Content/Selection/Railing.modulate = player_1_color
	$Content/Characters/Scarlett.grab_focus()

func switch_player():
	current_mode = PLAYER_2
	$Content/Selection/Railing.modulate = player_2_color

func end_selection():
	current_mode = null
	$Content/Selection/Railing.modulate = Color("ffffff")
	$Content/Selection/Play.disabled = false

func _on_Scarlett_pressed():
	match current_mode:
		PLAYER_1:
			$Content/Characters/Scarlett/Selection.player_1 = true
			player_1_selection = scarlett
			switch_player()
		PLAYER_2:
			$Content/Characters/Scarlett/Selection.player_2 = true
			player_2_selection = scarlett
			end_selection()
	$Content/Characters/Scarlett/Sound.play()

func _on_Jasmine_pressed():
	match current_mode:
		PLAYER_1:
			$Content/Characters/Jasmine/Selection.player_1 = true
			player_1_selection = jasmine
			switch_player()
		PLAYER_2:
			$Content/Characters/Jasmine/Selection.player_2 = true
			player_2_selection = jasmine
			end_selection()
	$Content/Characters/Jasmine/Sound.play()

func _on_Lilith_pressed():
	match current_mode:
		PLAYER_1:
			$Content/Characters/Lilith/Selection.player_1 = true
			player_1_selection = lilith
			switch_player()
		PLAYER_2:
			$Content/Characters/Lilith/Selection.player_2 = true
			player_2_selection = lilith
			end_selection()
	# TODO
	# Insert Sounds
	#$CenterContainer/VBoxContainer/Characters/Lilith/Sound.play()

func _on_Play_pressed():
	if get_parent().has_method("request_match_start"):
		get_parent().request_match_start([player_1_selection, player_2_selection])
	
	current_mode = PLAYER_1
	$Content/Characters/Scarlett/Selection.reset()
	$Content/Characters/Jasmine/Selection.reset()
	$Content/Characters/Lilith/Selection.reset()
	
	self.queue_free()

