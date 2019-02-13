extends Area2D

signal pick_up_spawned(impulse, position)

export(int) var mana_increase = 15
export(PackedScene) var impulse_template


func _ready():
	var impulse = impulse_template.instance()
	$SpawnEffect.start()
	emit_signal("pick_up_spawned", impulse, self.global_position)

func _on_PickUp_Mana_body_entered(body):
	
	if body is KinematicBody2D:
		body.increase_mana(mana_increase)
		self.queue_free()

func _on_DespawnTimer_timeout():
	self.queue_free()
