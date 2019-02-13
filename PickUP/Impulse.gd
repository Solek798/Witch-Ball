extends Tween

export(float) var distance = 200.0
export(float) var strength = 4.0
export(float) var time = 1.0


func apply_impulse():
	self.interpolate_property(self, 
							  "strength", 
							  strength, 
							  0.0, time, 
							  TRANS_QUAD, 
							  EASE_OUT)
	
	self.start()

func get_strength():
	return strength
