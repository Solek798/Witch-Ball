extends "res://Bullet/bullet.gd"


func _on_BulletDetection_body_entered(body):
	if body == self:
		return
	# TODO !!!!!
	#print(body)
	#print(body is RigidBody2D)
	#print(body.has_method("_on_BulletDetection_body_entered"))
	#if body is RigidBody2D and not body.has_method("_on_BulletDetection_body_entered"):
	if body.is_in_group("Bullet") and not body.name.matchn("*BigBullet*"):
		body.queue_free()
