extends RigidBody2D

export(PackedScene) var explosion_template
export(Resource) var sfx_stone
export(Resource) var sfx_tree
export(Resource) var sfx_player
export(int) var speed
export(int) var damage

signal bullet_destroyed(sound_effect, vfx_effect)

var own_player

func _ready():
	add_collision_exception_with(own_player)
	$Shot.play()

func _physics_process(delta):
	# scans for collisions
	var collision = get_colliding_bodies()
	
	if collision:
		# if the collider is a player, he takes the specified ammount of damage
		if collision.front().has_method("take_damage"):
			collision.front().take_damage(damage)
			$Collide.stream = sfx_player
			own_player._on_enemy_hit()
		
		destroy()

func destroy():
	var sound_effect = $Collide
	remove_child(sound_effect)
	sound_effect.global_position = self.global_position
	sound_effect.play()
	
	var vfx_effect = explosion_template.instance()
	vfx_effect.global_position = self.global_position
	vfx_effect.play()
	emit_signal("bullet_destroyed", sound_effect, vfx_effect)
	queue_free()
