extends Node2D

export(PackedScene) var pickup_mana_template
export(PackedScene) var pickup_fast_template
export(PackedScene) var pickup_big_template
export(PackedScene) var animation_template
export(int) var min_spawn_time
export(int) var max_spawn_time


func _ready():
	set_spawn_time()
	$SpawnTimer.start()

func _process(delta):
	# TEMP!
	# Cheat-shortcuts are going to be removed in final Version
	if Input.is_action_just_pressed("cheat_mana_pickup"):
		var new_pickup = pickup_mana_template.instance()
		$PickUp_Spawn/Follow.unit_offset = 0.5
		new_pickup.global_position = $PickUp_Spawn/Follow.global_position
		add_child(new_pickup)
	if Input.is_action_just_pressed("cheat_fast_pickup"):
		var new_pickup = pickup_fast_template.instance()
		$PickUp_Spawn/Follow.unit_offset = 0.5
		new_pickup.global_position = $PickUp_Spawn/Follow.global_position
		add_child(new_pickup)
	if Input.is_action_just_pressed("cheat_big_pickup"):
		var new_pickup = pickup_big_template.instance()
		$PickUp_Spawn/Follow.unit_offset = 0.5
		new_pickup.global_position = $PickUp_Spawn/Follow.global_position
		add_child(new_pickup)

func set_spawn_time():
	$SpawnTimer.wait_time = (randi() % (max_spawn_time - min_spawn_time)) + min_spawn_time

func _on_bullet_thrown(bullet):
	bullet.connect("bullet_destroyed", self, "_on_bullet_destroyed")
	add_child(bullet)

func _on_player_created(player):
	player.position = $Position.get_by_id(player.id)
	# TEMP
	if player.id == 2:
		player.scale.x *= -1
	add_child(player)

func _on_player_reseted(player):
	player.position = $Position.get_by_id(player.id)

func _on_SpawnTimer_timeout():
	$PickUp_Spawn/Follow.unit_offset = randf()
	
	var pick_up
	
	match randi() % 10:
		0, 1, 2, 3, 4:
			pick_up = pickup_mana_template.instance()
		5, 6, 7:
			pick_up = pickup_fast_template.instance()
		8, 9:
			pick_up = pickup_big_template.instance()
	
	pick_up.global_position = $PickUp_Spawn/Follow.global_position
	add_child(pick_up)
	
	set_spawn_time()

func _on_bullet_destroyed(sound_effect, vfx_effect):
	add_child(sound_effect)
	add_child(vfx_effect)

func _on_round_finished():
	for child in get_children():
		if child.is_in_group("Bullet") or child.is_in_group("PickUp"):
			child.queue_free()
	
	$SpawnTimer.stop()
	set_spawn_time()
	$SpawnTimer.start()

func _on_Stones_body_entered(body):
	pass

func _on_Leafs_body_entered(body):
	pass # replace with function body

func _on_Needles_body_entered(body):
	pass # replace with function body
