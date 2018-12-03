extends Container

export(PackedScene) var life_template


func _on_player_created(player):
	$Healthbar.add_life(player.id, player.health)

func _on_player_damaged(player, ammount):
	$Healthbar.remove_life(player.id, ammount)

func _on_player_reseted(player):
	$Healthbar.refill_life(player.id, player.max_health)
