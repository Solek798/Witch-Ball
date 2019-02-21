extends "res://PickUP/pick_up.gd"

export(int) var mana_gain = 5


func _on_ManaPickUp_body_entered(body):
	if body.has_method("increase_mana"):
		body.increase_mana(mana_gain)
		body.FillManaAnimation()
		self.queue_free()
