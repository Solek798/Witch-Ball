extends Sprite

export(Resource) var round_filled
export(Resource) var round_empty

var is_filled = false setget set_filled

func set_filled(fill):
	if fill:
		self.texture = round_filled
		$AnimationTreePlayer.oneshot_node_start("oneshot_Round")
		
	else:
		self.texture = round_empty
	is_filled = fill

