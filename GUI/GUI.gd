extends Container

export(PackedScene) var life_template

signal player_won_match(player)


func _on_player_created(player):
	$Healthbar.add_life(player.id, player.health)

func _on_player_damaged(player, ammount):
	$Healthbar.remove_life(player.id, ammount)

func _on_player_reseted(player):
	$Healthbar.refill_life(player.id, player.max_health)

func _on_player_won_round(player):
	var won_match = $Top/Info.set_winner(player.id)
	if won_match:
		emit_signal("player_won_match", player)

func _on_match_started(round_count):
	$Top/Info.set_rounds(round_count)