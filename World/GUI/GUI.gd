extends Container

export(PackedScene) var life_template

func _on_player_created(player):
	for i in range(player.health):
		var new_life = life_template.instance()
		get_node("Healthbars/Player%dHealthbar" % player.player_id).add_child(new_life)


