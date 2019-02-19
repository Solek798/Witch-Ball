extends "res://Bullet/bullet.gd"


func _on_BulletDetection_body_entered(body):
	if body != self and not body.has_method("_on_BulletDetection_body_entered"):
		body.queue_free()
