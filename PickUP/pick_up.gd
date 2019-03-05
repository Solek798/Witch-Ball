extends Area2D

signal pick_up_spawned(impulse)

export(PackedScene) var impulse_template


func _ready():
	$Animation.play("Spawn")

func create_shockwave():
	var impulse = impulse_template.instance()
	impulse.position = self.global_position
	emit_signal("pick_up_spawned", impulse)

func destroy(destruction_animation):
	$CollisionShape.shape = null
	$Animation.play(destruction_animation)
	yield($Animation, "animation_finished")
	
	self.queue_free()

func _on_DespawnTimer_timeout():
	destroy("Vanish")

