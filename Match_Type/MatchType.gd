extends Node

export(PackedScene) var arena_template
export(PackedScene) var gui_template
export(PackedScene) var backstage_template
export(int) var player_count
# TEMP
export(PackedScene) var player_template

signal player_created(player)

onready var players = []

var arena
var gui
var backstage


func _ready():
	arena = arena_template.instance()
	gui = gui_template.instance()
	backstage = backstage_template.instance()
	
	add_child(arena)
	add_child(gui)
	add_child(backstage)
	
	self.connect("player_created", arena, "_on_player_created")
	self.connect("player_created", gui, "_on_player_created")
	
	# creates the in player_count specified ammount of players
	for i in player_count:
		players.append(create_player(players.size() + 1))

func create_player(id):
	#instanciates and sets th player to the specified position
	var player = player_template.instance()
	player.id = id
	# connects all player relevant signals
	player.connect("bullet_thrown", arena, "_on_bullet_thrown")
	player.connect("player_damaged", gui, "_on_player_damaged")
	player.connect("player_died", backstage, "_on_player_died")
	player.connect("player_reseted", gui, "_on_player_reseted")
	player.connect("player_reseted", arena, "_on_player_reseted")
	backstage.connect("round_finished", player, "_on_round_finished")
	
	emit_signal("player_created", player)
	return player
