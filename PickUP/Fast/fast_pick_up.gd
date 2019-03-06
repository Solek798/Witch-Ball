extends "res://PickUP/pick_up.gd"


func _on_FastPickUp_body_entered(body):
	if body.has_method("set_big_shot"):
		body.fast_shot = true
		$Collect.play()
		.destroy("Consume")


func _on_Animation_animation_finished(anim_name):
	if anim_name == "Spawn":
		$Animation.play("Idle1")
		$Particles/FastEffect.emitting = true
