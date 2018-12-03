extends CanvasLayer

export(PackedScene) var player_scene
export(int) var player_count

onready var players = []


func _ready():
	# creates the in player_count specified ammount of players
	for i in player_count:
		players.append(create_player(players.size() + 1))




func reset_all_players():
	# startes and waits for the EndRoundTimer (EndScreenTimer) to finish
	$EndRoundTimer.start()
	yield($EndRoundTimer, "timeout")
	
	# resets all players
	for player in players:
		player.reset()
		player.position = get_node("PositionPlayer%d" % player.id).position

func _on_bullet_thrown(bullet):
	add_child(bullet) 

func _on_player_dead(player):
	# TODO; display Win Message
	reset_all_players()


