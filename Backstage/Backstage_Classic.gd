extends Node

signal round_finished


func _on_player_died(player):
	# startes and waits for the EndRoundTimer (EndScreenTimer) to finish
	$EndRoundTimer.start()
	yield($EndRoundTimer, "timeout")
	
	emit_signal("round_finished")
