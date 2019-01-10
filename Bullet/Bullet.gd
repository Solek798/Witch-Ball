extends RigidBody2D

export(int) var speed
export(int) var damage

signal bullet_destroyed(sounds)

var own_player

func _ready():
	add_collision_exception_with(own_player)
	$BulletShotSound.play()

func _process(delta):
	# scans for collisions
	var collision = get_colliding_bodies()
	
	if collision:
		manage_collision(collision)

func manage_collision(collision):
	# if the collider is a player, he takes the specified ammount of damage
	if collision.front().has_method("take_damage"):
		collision.front().take_damage(damage)
	
	$BulletCollideSound.play()
	var sounds = $BulletCollideSound
	self.remove_child(sounds)
	sounds.global_position = self.global_position
	emit_signal("bullet_destroyed", sounds)
	
	queue_free()