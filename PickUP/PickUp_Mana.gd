extends Area2D

export(int) var mana_increase = 15


func _on_PickUp_Mana_body_entered(body):
	
	if body is KinematicBody2D:
		body.increase_mana(mana_increase)
		self.queue_free()

func _on_DespawnTimer_timeout():
	self.queue_free()
