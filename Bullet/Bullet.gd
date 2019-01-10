extends RigidBody2D

export(int) var speed
export(int) var damage

signal bullet_destroyed(sound_effect)

var own_player

func _ready():
	add_collision_exception_with(own_player)
	$Shot.play()

func _process(delta):
	# scans for collisions
	var collision = get_colliding_bodies()
	
	if collision:
		# if the collider is a player, he takes the specified ammount of damage
		if collision.front().has_method("take_damage"):
			collision.front().take_damage(damage)
		
		var sound_effect = $Collide
		remove_child(sound_effect)
		sound_effect.global_position = self.global_position
		sound_effect.play()
		emit_signal("bullet_destroyed", sound_effect)
		queue_free()
		#emit_signal("bullet_destroyed")
