extends Node2D


func _on_bullet_thrown(bullet):
	add_child(bullet)

func _on_player_created(player):
	player.position = $Position.get_by_id(player.id)
	add_child(player)

func _on_player_reseted(player):
	player.position = $Position.get_by_id(player.id)
