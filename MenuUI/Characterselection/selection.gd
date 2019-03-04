extends Control

onready var player_1 = false setget set_player_1
onready var player_2 = false setget set_player_2


func set_player_1(new_value):
	player_1 = new_value
	if new_value:
		$Player1Selected.visible = true
		$Node2D/Player1.text = "P1"
	else:
		$Node2D/Player1.text = ""
		$Player1Selected.visible = false

func set_player_2(new_value):
	player_2 = new_value
	if new_value:
		$Player2Selected.visible = true
		$Node2D/Player2.text = "P2"
	else:
		$Player2.text = ""
		$Node2D/Player2.text = false

func reset():
	set_player_1(false)
	set_player_2(false)
