extends Area2D

signal pick_up_spawned(impulse, position)

export(PackedScene) var impulse_template


func _ready():
	var impulse = impulse_template.instance()
	emit_signal("pick_up_spawned", impulse, self.global_position)

func _on_PickUp_Fast_body_entered(body):
	
	if body is KinematicBody2D:
		body.fast_shot = true
		self.queue_free()


func _on_DespawnTimer_timeout():
	self.queue_free()
