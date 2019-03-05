extends Control

onready var player_1 = false setget set_player_1
onready var player_2 = false setget set_player_2


func set_player_1(new_value):
	pass
	player_1 = new_value
	#if new_value:
		#$Player1Selected.visible = true
		#$Player1.text = "P1"
	#else:
		#$Player1.text = ""
		#$Player1Selected.visible = false

func set_player_2(new_value):
	pass
	#player_2 = new_value
	#if new_value:
		#$Player2Selected.visible = true
		#$Player2.text = "P2"
	#else:
		#$Player2.text = ""
		#$Player2.text = false

func set_by_id(id):
	pass
	#if id == 1:
		#set_player_1(true)
	#if id == 2:
		#set_player_2(true)

func reset():
	pass
	#set_player_1(false)
	#set_player_2(false)
