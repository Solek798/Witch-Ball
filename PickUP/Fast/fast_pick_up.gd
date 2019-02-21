extends "res://PickUP/pick_up.gd"


func _on_FastPickUp_body_entered(body):
	if body.has_method("set_big_shot"):
		body.fast_shot = true
		GetPickUp()
		
		
func GetPickUp():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("GetPickUp")
	
func FreePickUp():
	self.queue_free()
