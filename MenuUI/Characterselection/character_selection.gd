extends Control

const player_1_color = Color("0900ff")
const player_2_color = Color("ff0000")

var PlayerIdentity = preload("res://Player/PlayerIdentity.gd")
var return_scene_template
var choosing_player
onready var player_identities = []

signal match_instantiated(new_match)

# TEMP
export(PackedScene) var match_template
export(PackedScene) var scarlett
export(PackedScene) var jasmine
export(PackedScene) var lilith
export(PackedScene) var penny

export(Resource) var red
export(Resource) var blue
export(Resource) var empty

func _ready():
	$Content/Characters/Scarlett.grab_focus()
	
	#if get_parent().has_method("get_current_controll"):
	choosing_player = get_parent().current_controll
	$AnimationPlayer.play("FadeIn")
	$Content/Characters/Scarlett/PanelAnimations/Selections.texture = blue
	$Content/Characters/Jasmine/PanelAnimations/Selections.texture = blue
	$Content/Characters/Lilith/PanelAnimations/Selections.texture = blue
	$Content/Characters/Penny/PanelAnimations/Selections.texture = blue

func switch_player():
	$Content/Characters/Scarlett/PanelAnimations/Selections.texture = red
	$Content/Characters/Jasmine/PanelAnimations/Selections.texture = red
	$Content/Characters/Lilith/PanelAnimations/Selections.texture = red
	$Content/Characters/Penny/PanelAnimations/Selections.texture = red
	if get_parent().has_method("switch_controlls"):
		
		var next_player = get_parent().switch_controlls(choosing_player.device + 1)
		
		if not next_player:
			end_selection()
			get_parent().switch_controlls(0)
		else:
			choosing_player = next_player

func end_selection():
	#$Content/Selection/Railing.modulate = Color("ffffff")
	$Content/Characters/Scarlett/PanelAnimations/Selections.texture = empty
	$Content/Characters/Jasmine/PanelAnimations/Selections.texture = empty
	$Content/Characters/Lilith/PanelAnimations/Selections.texture = empty
	$Content/Characters/Penny/PanelAnimations/Selections.texture = empty
	$Selection/VBoxContainer/HBoxContainer/Play.disabled = false

func _on_Scarlett_pressed():
	select($Content/Characters/Scarlett/Selection, scarlett, $Content/Characters/Scarlett/Sound)

func _on_Jasmine_pressed():
	select($Content/Characters/Jasmine/Selection, jasmine, $Content/Characters/Jasmine/Sound)

func _on_Lilith_pressed():
	select($Content/Characters/Lilith/Selection, lilith, $Content/Characters/Lilith/Sound)

func _on_Penny_pressed():
	select($Content/Characters/Penny/Selection, penny, $Content/Characters/Penny/Sound)

func select(selection, character, voice):
	selection.set_by_id(choosing_player.device + 1)
	
	# TEMP
	var side = PlayerIdentity.LEFT_SIDE
	if (choosing_player.device + 1) % 2 == 0:
		side = PlayerIdentity.RIGHT_SIDE
	
	var identity = PlayerIdentity.new(
			choosing_player.device + 1, 
			choosing_player, 
			character,
			side
	)
	
	player_identities.append(identity)
	voice.play()
	
	switch_player()

func _on_Play_pressed():
	if get_parent().has_method("confirm_selection"):
		
		get_parent().confirm_selection(player_identities)
	
	self.queue_free()
	
func _on_Menu_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene(return_scene_template, null)
		$AnimationPlayer.play("FadeOut")
	self.queue_free()



