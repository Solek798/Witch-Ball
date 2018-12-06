extends HBoxContainer

export(PackedScene) var round_template



func set_winner(id):
	var children = get_node("Player%dwins/Player%dRounds" % [id, id]).get_children()
	for i in children.size():
		if not children[i].is_filled:
			children[i].is_filled = true
			return i == children.size() - 1

func set_rounds(ammount):
	for i in ammount:
		$Player1wins/Player1Rounds.add_child(round_template.instance())
		$Player2wins/Player2Rounds.add_child(round_template.instance())