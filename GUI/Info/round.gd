extends Sprite

export(Resource) var round_filled
export(Resource) var round_empty

var is_filled = false setget set_filled

func set_filled(fill):
	if fill:
		$AnimationPlayer.play("Gewinn")
	else:
		self.texture = round_empty
	is_filled = fill

func RoundIsFilled():
	self.texture = round_filled
	