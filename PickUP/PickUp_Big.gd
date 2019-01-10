extends Area2D


func _on_PickUp_Big_body_entered(body):
	
	if body is KinematicBody2D:
		body.big_shot = true
		self.queue_free()


func _on_DespawnTimer_timeout():
	self.queue_free()
