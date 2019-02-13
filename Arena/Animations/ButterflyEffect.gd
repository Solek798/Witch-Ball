extends Sprite


func start():
	$Animation.play("Butterfly")
	print("Start Butterfly")

func _on_Animation_animation_finished(anim_name):
	self.queue_free()
