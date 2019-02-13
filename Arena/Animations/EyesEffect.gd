extends Sprite


func start():
	$Animation.play("Eyes")
	print("start eyes")

func _on_Animation_animation_finished(anim_name):
	self.queue_free()
