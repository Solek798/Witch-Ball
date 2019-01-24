extends HBoxContainer

export(Texture) var round_empty_template
export(Texture) var round_won_template



func set_winner(id):
	var children = get_node("Railing/Player%d" % id).get_children()
	
	for child in children:
		if not child.is_filled:
			child.is_filled = true
			break
	
	return get_node("Railing/Player%d/Round3" % id).is_filled