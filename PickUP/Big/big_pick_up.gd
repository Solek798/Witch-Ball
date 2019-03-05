extends "res://PickUP/pick_up.gd"


func _on_BigPickUp_body_entered(body):
	
	if body.has_method("set_big_shot"):
		body.big_shot = true
		.destroy("Consume")

func _on_Animation_animation_finished(anim_name):
	if anim_name == "Spawn":
		$Animation.play("Idle")
		$Shockwafe.emitting = true
