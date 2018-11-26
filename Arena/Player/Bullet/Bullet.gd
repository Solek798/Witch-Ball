extends RigidBody2D

export(int) var damage

signal bullet_destroyed()


func _process(delta):
	# scans for collisions
	var collision = get_colliding_bodies()
	
	if collision:
		# if the collider is a player, he takes the specified ammount of damage
		if collision.front().has_method("take_damage"):
			collision.front().take_damage(damage)
		queue_free()
		#emit_signal("bullet_destroyed")
