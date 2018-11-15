extends Container

export(PackedScene) var life_template

func _on_player_created(player):
	for i in range(player.health):
		var new_life = life_template.instance()
		get_node("Healthbars/Player%dHealthbar" % player.player_id).add_child(new_life)

func _on_player_damaged(player_id, ammount):
	var children = get_node("Healthbars/Player%dHealthbar" % player_id).get_children()
	
	if not children:
		return
	for i in ammount:
		children.pop_back().queue_free()