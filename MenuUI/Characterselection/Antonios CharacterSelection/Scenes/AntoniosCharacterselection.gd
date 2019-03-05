extends Control

enum mode {PLAYER_1 = 1, PLAYER_2 = 2}
const player_1_color = Color("0900ff")
const player_2_color = Color("ff0000")

var return_scene_template
var current_mode
var player_1_selection
var player_2_selection

signal match_instantiated(new_match)

# TEMP
export(PackedScene) var match_template
export(PackedScene) var scarlett
export(PackedScene) var jasmine
export(PackedScene) var lilith
export(PackedScene) var penny
export(Resource) var BlueSelect
export(Resource) var RedSelect

func _ready():
	$VStucktur/HStrucktur/Content/Pannels/Scarlett.grab_focus()
	current_mode = PLAYER_1
	$VStucktur/HStrucktur/Content/Pannels/Scarlett/PanelAnimations/PlayerOneselecting.texture = BlueSelect
	$VStucktur/HStrucktur/Content/Pannels/Jasmine/PanelAnimations/PlayerOneselecting.texture = BlueSelect
	$VStucktur/HStrucktur/Content/Pannels/Lilith/PanelAnimations/PlayerOneselecting.texture = BlueSelect
	$VStucktur/HStrucktur/Content/Pannels/Penny/PanelAnimations/PlayerOneselecting.texture = BlueSelect

func switch_player():
	current_mode = PLAYER_2
	$VStucktur/HStrucktur/Content/Pannels/Scarlett/PanelAnimations/PlayerOneselecting.texture = RedSelect
	$VStucktur/HStrucktur/Content/Pannels/Jasmine/PanelAnimations/PlayerOneselecting.texture = RedSelect
	$VStucktur/HStrucktur/Content/Pannels/Lilith/PanelAnimations/PlayerOneselecting.texture = RedSelect
	$VStucktur/HStrucktur/Content/Pannels/Penny/PanelAnimations/PlayerOneselecting.texture = RedSelect


func end_selection():
	current_mode = null
	$VStucktur/HStrucktur/Footer/Play.disabled = false

func _on_Scarlett_pressed():
	match current_mode:
		PLAYER_1:
			$VStucktur/HStrucktur/Content/Pannels/Scarlett/Selection.player_1 = true
			player_1_selection = scarlett
			switch_player()
		PLAYER_2:
			$VStucktur/HStrucktur/Content/Pannels/Scarlett/Selection.player_2 = true
			player_2_selection = scarlett
			end_selection()
	$VStucktur/HStrucktur/Content/Pannels/Scarlett/Sound.play()

func _on_Jasmine_pressed():
	match current_mode:
		PLAYER_1:
			$VStucktur/HStrucktur/Content/Pannels/Jasmine/Selection.player_1 = true
			player_1_selection = jasmine
			switch_player()
		PLAYER_2:
			$VStucktur/HStrucktur/Content/Pannels/Jasmine/Selection.player_2 = true
			player_2_selection = jasmine
			end_selection()
	$VStucktur/HStrucktur/Content/Pannels/Jasmine/Sound.play()


func _on_Lilith_pressed():
	match current_mode:
		PLAYER_1:
			$VStucktur/HStrucktur/Content/Pannels/Lilith/Selection.player_1 = true
			player_1_selection = lilith
			switch_player()
		PLAYER_2:
			$VStucktur/HStrucktur/Content/Pannels/Lilith/Selection.player_2 = true
			player_2_selection = lilith
			end_selection()
	$VStucktur/HStrucktur/Content/Pannels/Lilith/Sound.play()

func _on_Penny_pressed():
	match current_mode:
		PLAYER_1:
			$VStucktur/HStrucktur/Content/Pannels/Penny/Selection.player_1 = true
			player_1_selection = penny
			switch_player()
		PLAYER_2:
			$VStucktur/HStrucktur/Content/Pannels/Penny/Selection.player_2 = true
			player_2_selection = penny
			end_selection()
	$VStucktur/HStrucktur/Content/Pannels/Penny/Sound.play()
	

func _on_Play_pressed():
	if get_parent().has_method("confirm_selection"):
		get_parent().confirm_selection([player_1_selection, player_2_selection])
	
	self.queue_free()
