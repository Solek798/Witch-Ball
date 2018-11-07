extends Node2D

export(PackedScene) var player_scene

signal player_created

onready var players = []

func _ready():
	players.append(player_scene.instance())
	players.back().player_id = players.size()
	add_child(players.back())
	
	#players.append(player_scene.instance())
	#players.back().player_id = players.size()
	#add_child(players.back())

