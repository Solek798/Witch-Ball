extends AnimationPlayer

export(float) var distance = 400.0
export(float) var strength = 1.0

var mov

func apply_impulse():
	self.play("Impulse")

func get_current_impulse():
	return strength
