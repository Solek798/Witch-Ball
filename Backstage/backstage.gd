extends Node

signal round_started
signal round_finished
signal player_won_round(player)

onready var players = []


func _ready():
	$Music.play()

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
		emit_signal("round_finished")
		
		players.back().won_rounds += 1
		
		emit_signal("player_won_round", players.back())
		
		$RoundWon.play()
		$EndRoundTimer.start()
		yield($EndRoundTimer, "timeout")
		
		Transition.on()
		yield(Transition, "done_on")
		
		emit_signal("round_started")
		
		Transition.off()

func _on_AudioStreamPlayer_finished():
	$Music.play(2.0)
