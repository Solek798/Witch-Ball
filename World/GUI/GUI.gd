extends Container

export(PackedScene) var life_template


func add_life(player_id):
	var new_life = life_template.instance()
	get_node("Healthbars/Player%dHealthbar" % player_id).add_child(new_life)

func remove_life(player_id):
	var children = get_node("Healthbars/Player%dHealthbar" % player_id).get_children()
	if children:
		children.pop_back().queue_free()

func _on_player_created(player):
	for i in range(player.health):
		add_life(player.player_id)

func _on_player_damaged(player, ammount):
	for i in ammount:
		remove_life(player.player_id)

func _on_player_reset(player):
	var children = get_node("Healthbars/Player%dHealthbar" % player.player_id).get_children()
	print(children)
	for i in player.max_health-children.size():
		add_life(player.player_id)
