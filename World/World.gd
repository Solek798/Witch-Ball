extends CanvasLayer

export(PackedScene) var player_scene
export(int) var player_count

signal player_created

onready var players = []

func _ready():
	self.connect("player_created", $GUI, "_on_player_created")
	
	for i in player_count:
		players.append(create_player(players.size() + 1))
	

func create_player(id):
	var player = player_scene.instance()
	player.position = get_node("PositionPlayer%d" % id).position
	player.player_id = id
	player.connect("projectile_thrown", self, "_on_projectile_thrown")
	player.connect("player_damaged", $GUI, "_on_player_damaged")
	player.connect("player_dead", self, "_on_player_dead")
	player.connect("player_reset", $GUI, "_on_player_reset")
	add_child(player)
	emit_signal("player_created", player)
	return player

func reset_all_players():
	$EndRound.start()
	yield($EndRound, "timeout")
	
	for player in players:
		player.reset()
		player.position = get_node("PositionPlayer%d" % player.player_id).position

func _on_projectile_thrown(node):
	add_child(node) 

func _on_player_dead(player):
	# display Win Message
	reset_all_players()


