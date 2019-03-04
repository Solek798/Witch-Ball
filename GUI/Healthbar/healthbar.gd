extends Container

export(PackedScene) var life_template

func add_image(player_identity, image):
	var sprite = get_node("Player%d/Image" % player_identity.id)
	sprite.texture = image
	sprite.scale *= player_identity.side

func add_life(player_id, ammount):
	for i in ammount:
		var new_life = life_template.instance()
		get_node("Player%d/Health" % player_id).add_child(new_life)

func remove_life(player_id, ammount):
	var children = get_node("Player%d/Health" % player_id).get_children()
	children.invert()
	
	for child in children:
		if child.is_filled:
			child.is_filled = false
			ammount -= 1
		
		if ammount <= 0:
			return

func refill_life(player_id, max_health):
	var children = get_node("Player%d/Health" % player_id).get_children()
	
	for child in children:
		child.is_filled = true
	
	
	
	