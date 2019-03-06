extends "res://Bullet/bullet.gd"


func _on_BulletDetection_body_entered(body):
	if body == self:
		return
	
	if body.is_in_group("Bullet") and not body.name.matchn("*BigBullet*"):
		body.queue_free()
