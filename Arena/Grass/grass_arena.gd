extends "res://Arena/arena.gd"

func _on_Stones_body_entered(body):
	if body is RigidBody2D:
		var anim = stone_effect_template.instance()
		anim.global_position = body.global_position
		anim.emitting = true
		add_child(anim)
		body.get_node("Collide").stream = body.sfx_stone
		body.destroy()

func _on_Needles_body_entered(body):
	if body is RigidBody2D:
		var anim = needle_effect_template.instance()
		anim.global_position = body.global_position
		anim.emitting = true
		
		var sound = AudioStreamPlayer2D.new()
		sound.global_position = body.global_position
		add_child(sound)
		sound.stream = body.sfx_tree
		sound.play()
		
		add_child(anim)
