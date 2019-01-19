extends HBoxContainer

export(Texture) var round_empty_template
export(Texture) var round_won_template



func set_winner(id):
	var children = get_node("Player%dwins/Player%dRounds" % [id, id]).get_children()
	
	for i in children.size():
		if id == 2:
			i = -i - 1
		print(i)
		if not children[i].is_filled:
			children[i].is_filled = true
			if id == 2:
				return i == -children.size()
			return i == children.size() - 1