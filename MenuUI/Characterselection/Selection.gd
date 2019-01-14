extends Control

onready var player_1 = false setget set_player_1
onready var player_2 = false setget set_player_2


func set_player_1(new_value):
	player_1 = new_value
	$Player_1.visible = new_value

func set_player_2(new_value):
	player_2 = new_value
	$Player_2.visible = new_value

func reset():
	set_player_1(false)
	set_player_2(false)
