extends Node

export(PackedScene) var arena_template
export(PackedScene) var gui_template
export(PackedScene) var backstage_template
export(PackedScene) var tutorial_template
export(PackedScene) var player_template
export(int) var player_count
export(int) var round_count

signal match_instanciated()
signal match_started(round_count)
signal match_finished(finished_match)
signal match_reseted
signal player_created(player)

var arena
var gui
var backstage
var player_identities


func _ready():
	initialize()
	print("match_instanciated")
	emit_signal("match_instanciated")

func initialize():
	arena = arena_template.instance()
	gui = gui_template.instance()
	backstage = backstage_template.instance()
	
	add_child(arena)
	add_child(gui)
	add_child(backstage)
	
	
	self.connect("player_created", arena, "_on_player_created")
	self.connect("player_created", gui, "_on_player_created")
	self.connect("player_created", backstage, "_on_player_created")
	self.connect("match_started", gui, "_on_match_started")
	self.connect("match_started", arena, "_on_match_started")
	backstage.connect("player_won_round", gui, "_on_player_won_round")
	backstage.connect("round_finished", arena, "_on_round_finished")
	backstage.connect("round_started", arena, "_on_round_started")
	gui.connect("player_won_match", self, "_on_player_won_match")

func start():
	# creates the in player_count specified ammount of players
	for i in player_count:
		create_player(player_identities[i])
	
	emit_signal("match_started", round_count)

func reset():
	
	# delete "old" match
	arena.free()
	backstage.free()
	gui.free()
	
	# re-initialized match
	initialize()
	start()
	
	emit_signal("match_reseted")

func stop():
	emit_signal("match_finished", self)

func create_player(identity):
	#instanciates and sets th player to the specified position
	var player = player_template.instance()
	player.identity = identity
	# connects all player relevant signals
	player.connect("bullet_thrown", arena, "_on_bullet_thrown")
	player.connect("player_damaged", gui, "_on_player_damaged")
	player.connect("player_died", backstage, "_on_player_died")
	player.connect("player_reseted", gui, "_on_player_reseted")
	player.connect("player_reseted", arena, "_on_player_reseted")
	player.connect("player_reseted", backstage, "_on_player_reseted")
	backstage.connect("round_started", player, "_on_round_started")
	backstage.connect("player_won_round", player, "_on_player_won_round" )
	gui.connect("player_won_match", player, "_on_player_won_match")
	
	emit_signal("player_created", player)

func _on_player_won_match(player):
	print("Spieler ", player.identity.id, " kriegt einen Keks")
	yield(backstage, "round_finished")
	stop()