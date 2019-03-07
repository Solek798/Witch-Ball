extends "res://Arena/arena.gd"

export(PackedScene) var stone_effect_template
export(PackedScene) var needle_effect_template
export(PackedScene) var eye_effect_template
export(PackedScene) var butterfly_effect_template
export(int) var min_effect_time = 6
export(int) var max_effect_time = 10


func set_effect_time():
	$Timer/RandomEffect.wait_time = (randi() % (max_effect_time - min_effect_time)) + min_effect_time

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
		sound.volume_db = -5
		add_child(sound)
		sound.stream = body.sfx_tree
		sound.play()
		
		add_child(anim)

func _on_RandomEffect_timeout():
	var children
	var effect
	
	if bool(round(randf())):
		children = $Eyes.get_children()
		effect = eye_effect_template.instance()
	else:
		children = $Butterflies.get_children()
		effect = butterfly_effect_template.instance()
	
	effect.position = children[randi() % children.size()].position
	effect.start()
	
	add_child(effect)
	
	set_effect_time()
	$Timer/RandomEffect.start()
