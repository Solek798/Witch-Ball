extends Container

export(PackedScene) var life_template

func add_life(player_id, ammount):
	for i in ammount:
		var new_life = life_template.instance()
		get_node("Text%d/Player%d" % [player_id, player_id]).add_child(new_life)

func remove_life(player_id, ammount):
	for i in ammount:
		var children = get_node("Player%d" % player_id).get_children()
		if children:
			children.pop_back().queue_free()

func refill_life(player_id, max_health):
	var children = get_node("Player%d" % player_id).get_children()
	add_life(player_id, max_health - children.size())