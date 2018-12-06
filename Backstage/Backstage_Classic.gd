extends Node

signal round_finished
signal player_won_round(player)

onready var players = []
onready var match_winner = null

func _on_player_created(player):
	players.append(player)

func _on_player_died(player):
	players.erase(player)
	update_round_state()

func _on_player_reseted(player):
	if not players.has(player):
		players.append(player)

func update_round_state():
	if players.size() == 1:
		players.back().won_rounds += 1
		emit_signal("player_won_round", players.back())
		# startes and waits for the EndRoundTimer (EndScreenTimer) to finish
		$EndRoundTimer.start()
		yield($EndRoundTimer, "timeout")
		
		if match_winner:
			pass
		else:
			emit_signal("round_finished")
