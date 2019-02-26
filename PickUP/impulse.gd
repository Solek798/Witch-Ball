extends Tween

export(float) var distance = 200.0
export(float) var strength = 1.0
export(float) var time = 1.0

var position


func apply_impulse():
	self.interpolate_property(self, "strength", strength, 0.0, time, TRANS_QUAD, EASE_OUT)
	self.start()

func get_strength():
	return strength

func _on_Impulse_tween_completed(object, key):
	yield(get_tree(), "idle_frame")
	self.queue_free()
