extends CanvasLayer

export(PackedScene) var player_scene
export(Vector2) var player1_position
export(Vector2) var player2_position
export(Vector2) var player1_scale
export(Vector2) var player2_scale

signal player_created

onready var players = []

func _ready():
	self.connect("player_created", $GUI, "_on_player_created")
	
	players.append(player_scene.instance())
	players.back().position = player1_position
	players.back().scale = player1_scale
	players.back().player_id = players.size()
	players.back().connect("projectile_thrown", self, "_on_projectile_thrown")
	add_child(players.back())
	emit_signal("player_created", players.back())
	
	players.append(player_scene.instance())
	players.back().position = player2_position
	players.back().scale = player2_scale
	players.back().player_id = players.size()
	players.back().connect("projectile_thrown", self, "_on_projectile_thrown")
	add_child(players.back())
	emit_signal("player_created", players.back())

func _on_projectile_thrown(node):
	add_child(node) 