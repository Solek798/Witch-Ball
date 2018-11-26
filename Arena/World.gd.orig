extends Node2D

export(PackedScene) var player_scene

signal player_created

onready var players = []

func _ready():
	players.append(player_scene.instance())
	players.back().player_id = players.size()
	players.back().position = Vector2(500, 500)
	add_child(players.back())
	
	var player2 = player_scene.instance()
	players.append(player2)
	players.back().player_id = players.size()
	players.back().position = Vector2(1500, 500)
	player2.transform.scaled(Vector2(-1,1))
	add_child(players.back())

