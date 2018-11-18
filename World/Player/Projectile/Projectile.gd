extends RigidBody2D

export(int) var damage

signal projectile_destroyed()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var collision = get_colliding_bodies()
	
	if collision:
		if collision.front().has_method("take_damage"):
			collision.front().take_damage(damage)
		queue_free()
		#emit_signal("projectile_destroyed")
