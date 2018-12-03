extends Node

export(PackedScene) var arena
export(PackedScene) var gui
export(PackedScene) var backstage
export(PackedScene) var player_scene
export(int) var player_count

onready var players = []

var arena
var gui
var backstage


func _ready():
	# creates the in player_count specified ammount of players
	for i in player_count:
		players.append(create_player(players.size() + 1))

func create_player(id):
	#instanciates and sets th player to the specified position
	var player = player_scene.instance()
	player.position = get_node("PositionPlayer%d" % id).position
	player.id = id
	# connects all player relevant signals
	player.connect("bullet_thrown", self, "_on_bullet_thrown")
	player.connect("player_created", $GUI, "_on_player_created")
	player.connect("player_damaged", $GUI, "_on_player_damaged")
	player.connect("player_dead", self, "_on_player_dead")
	player.connect("player_reset", $GUI, "_on_player_reset")
	# adds the player to the world
	add_child(player)
	return player
