extends Node2D

export(PackedScene) var pickup_mana_template
export(PackedScene) var pickup_fast_template
export(PackedScene) var pickup_big_template
export(int) var min_spawn_time
export(int) var max_spawn_time
export(int) var time_divider = 2

onready var players = []

var min_time
var max_time

func _ready():
	min_time = min_spawn_time
	max_time = max_spawn_time

func _process(delta):
	# TEMP!
	# Cheat-shortcuts are going to be removed in final Version
	if Input.is_action_just_pressed("cheat_mana_pickup"):
		$PickUp_Spawn/Follow.unit_offset = 0.5
		spawn_pickup(pickup_mana_template)
	if Input.is_action_just_pressed("cheat_fast_pickup"):
		$PickUp_Spawn/Follow.unit_offset = 0.5
		spawn_pickup(pickup_fast_template)
	if Input.is_action_just_pressed("cheat_big_pickup"):
		$PickUp_Spawn/Follow.unit_offset = 0.5
		spawn_pickup(pickup_big_template)

func set_spawn_time():
	$Timer/PickUpSpawner.wait_time = (randi() % (max_time - min_time)) + min_time

func spawn_pickup(template):
	var pick_up = template.instance()
	pick_up.global_position = $PickUp_Spawn/Follow.global_position
	for player in players:
		pick_up.connect("pick_up_spawned", player, "_on_pick_up_spawned")
	add_child(pick_up)

func _on_bullet_thrown(bullet):
	bullet.connect("bullet_destroyed", self, "_on_bullet_destroyed")
	add_child(bullet)

func _on_player_created(player):
	player.position = $Position.get_by_id(player.identity.id)
	
	player.scale *= player.identity.side
	add_child(player)
	players.append(player)

func _on_player_reseted(player):
	player.position = $Position.get_by_id(player.identity.id)

func _on_match_started(round_count):
	set_spawn_time()
	$Timer/PickUpSpawner.start()
	$Timer/PickUpSpawnRate.start()

func _on_SpawnTimer_timeout():
	$PickUp_Spawn/Follow.unit_offset = randf()
	
	match randi() % 10:
		0, 1, 2, 3, 4:
			spawn_pickup(pickup_mana_template)
		5, 6, 7:
			spawn_pickup(pickup_fast_template)
		8, 9:
			spawn_pickup(pickup_big_template)
	
	set_spawn_time()

func _on_bullet_destroyed(sound_effect, vfx_effect):
	add_child(sound_effect)
	add_child(vfx_effect)

func _on_round_started():
	$Timer/PickUpSpawner.stop()

func _on_round_finished():
	for child in get_children():
		if child.is_in_group("Bullet") or child.is_in_group("PickUp"):
			child.queue_free()
	
	min_time = min_spawn_time
	max_time = max_spawn_time
	set_spawn_time()
	$Timer/PickUpSpawner.start()

func _on_PickUpTimer_timeout():
	min_time /= time_divider
	max_time /= time_divider

