extends Area2D

signal pick_up_spawned(impulse, position)

export(PackedScene) var impulse_template


func _ready():
	var impulse = impulse_template.instance()
	emit_signal("pick_up_spawned", impulse, self.global_position)

func _on_DespawnTimer_timeout():
	destroy("Vanish")

func destroy(destruction_animation):
	$CollisionShape.shape = null
	$Animation.play(destruction_animation)
	yield($Animation, "animation_finished")
	
	self.queue_free()
