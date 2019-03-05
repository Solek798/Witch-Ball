extends "res://PickUP/pick_up.gd"

export(int) var mana_gain = 5


func _on_ManaPickUp_body_entered(body):
	if body.has_method("increase_mana"):
		body.increase_mana(mana_gain)
		body.FillManaAnimation()
		.destroy("Consume")


func _on_Animation_animation_finished(anim_name):
	if anim_name == "Spawn":
		$Animation.play("Idle")
