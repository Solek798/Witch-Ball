extends "res://PickUP/pick_up.gd"


func _on_BigPickUp_body_entered(body):
	
	if body.has_method("set_big_shot"):
		body.big_shot = true
		GetPickUp()
		
		
func GetPickUp():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("GetPickUp")
	
func FreePickUp():
	self.queue_free()