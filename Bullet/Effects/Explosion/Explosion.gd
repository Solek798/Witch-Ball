extends AnimatedSprite


func _on_Explosion_animation_finished():
	self.queue_free()
