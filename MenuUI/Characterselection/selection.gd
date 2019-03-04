extends Control

onready var player_1 = false setget set_player_1
onready var player_2 = false setget set_player_2


func set_player_1(new_value):
	player_1 = new_value
	if new_value:
		$Player1.text = "P1"
	else:
		$Player1.text = ""

func set_player_2(new_value):
	player_2 = new_value
	if new_value:
		$Player2.text = "P2"
	else:
		$Player2.text = ""

func set_by_id(id):
	if id == 1:
		set_player_1(true)
	if id == 2:
		set_player_2(true)

func reset():
	set_player_1(false)
	set_player_2(false)
