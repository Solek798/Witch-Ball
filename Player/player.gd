extends KinematicBody2D

export(PackedScene) var bullet_template
export(PackedScene) var bullet_fast_template
export(PackedScene) var bullet_big_template
export(int) var movement_speed 
export(float) var aim_speed
export(float) var chance_to_say_something_stupid = 0.25
export(int) var max_health
export(int) var dodge_distance
export(int) var max_mana
export(int) var start_mana
export(int) var throw_mana
export(int) var dodge_mana
export(int) var mana_increase

signal bullet_thrown(bullet)
signal player_damaged(player, ammount)
signal player_died(player)
signal player_reseted(player)


var body
var next_bullet
var identity
onready var current_aim = 0.0
onready var current_movement = Vector2(0, 0)
onready var health = max_health
onready var is_dead = false
onready var fast_shot = false setget set_fast_shot
onready var big_shot = false setget set_big_shot
onready var won_rounds = 0

var imp

func _ready():
	randomize()
	
	body = identity.selection.instance()
	add_child(body)
	$Mana.max_value = max_mana
	$Mana.value = start_mana
	next_bullet = bullet_template

func _input(event):
	if not identity.controll.active:
		return
	# TEMP!
	# Cheat-shortcuts are going to be removed in final Version
	if Input.is_action_just_pressed("cheat_fast_bullet"):
		self.fast_shot = true
	if Input.is_action_just_pressed("cheat_big_bullet"):
		self.big_shot = true
	
	current_movement = identity.controll.get_movement() * movement_speed
	
	if current_movement:
		body.play_walk()
		$Smoke.emitting = true
	else:
		body.stop_walk()
		$Smoke.emitting = false
	
	if identity.controll.state(Action.THROW):
		throw(current_movement)
	if identity.controll.state(Action.DODGE):
		dodge()
	if identity.controll.state(Action.THROW_SPECIAL):
		if fast_shot:
			next_bullet = bullet_fast_template
			throw(current_movement)
		if big_shot:
			next_bullet = bullet_big_template
			throw(current_movement)

func _physics_process(delta):
	
	for mod in $Modifiers.get_children():
		if mod.has_method("get_strength"):
			$Modifiers.movement = imp * mod.get_strength()
	
	# moves player and scans for collisions
	move_and_slide(current_movement + $Modifiers.movement)
	
	# calculates the rotation in this frame and rotates the aim pointer
	var direction = identity.controll.get_aim()
	#direction *= identity.side
	current_aim = atan2(direction.y, direction.x)
	$Aim.rotation = current_aim


func throw(movement):
	# Don't throw while ThrowTimer is running or while you have no mana
	if $Timer/Throw.time_left > 0 or $Mana.value < throw_mana:
		if $Mana.value < throw_mana:
			identity.controll.vibrate(0.7, 0.2, 0.3)
		return
	
	# calculates throm impuls
	var player_position = self.global_position
	var throw_point_position = body.get_throw_point()
	
	
	# instanciates and sets a new bullet to thropoint position
	var bullet = next_bullet.instance()
	bullet.position = throw_point_position
	bullet.own_player = self
	var impulse
	
	impulse = Vector2(1, 0).rotated($Aim.rotation) * identity.side * bullet.speed
	
	# throw the bullet
	bullet.apply_impulse(throw_point_position, impulse)
	$Mana.value -= throw_mana
	
	if next_bullet != bullet_template:
		next_bullet = bullet_template
		set_fast_shot(false)
		set_big_shot(false)
	
	# start Timer for throw delay
	$Timer/Throw.start()
	body.play_throw(movement)
	emit_signal("bullet_thrown", bullet)
	
	if randf() < chance_to_say_something_stupid and not VoiceChannel.blocked:
		body.play_voice(VoiceChannel.THROW)

func dodge():
	if current_movement == Vector2(0, 0) or $Mana.value < dodge_mana:
		return
	
	# if player is not allready dodging, he starts to dodge
	if $Timer/Dodge.is_stopped():
		$Mana.value -= dodge_mana
		identity.controll.active = false
		$Timer/Dodge.start()
		
		var dodge_vector = Vector2(1, 0) * dodge_distance
		dodge_vector = dodge_vector.rotated(atan2(current_movement.y, current_movement.x))
		current_movement = dodge_vector / $Timer/Dodge.wait_time
		
		body.set_motion_blur(true, current_movement * get_process_delta_time())

func take_damage(ammount):
	if is_dead or $Timer/Indestructable.time_left:
		return
	
	body.play_hit()
	if randf() < chance_to_say_something_stupid and not VoiceChannel.blocked:
		body.play_voice(VoiceChannel.HIT)
	$Timer/Indestructable.start()
	health -= ammount
	identity.controll.vibrate(0.6, 0.6, 0.2)
	emit_signal("player_damaged", self, ammount)
	
	if health <= 0:
		identity.controll.active = false
		is_dead = true
		emit_signal("player_died", self)

func reset():
	# all values that could have been changed are reset to default
	health = max_health
	$Mana.value = start_mana
	$Aim.rotation = 0
	identity.controll.active = true
	is_dead = false
	VoiceChannel.blocked = false
	emit_signal("player_reseted", self)

func increase_mana(ammount):
	$Mana.value += ammount

func set_big_shot(new_value):
	if new_value:
		fast_shot = false
		$Aim/Special/Fast.visible = false
	
	big_shot = new_value
	$Aim/Special/Big.visible = new_value

func set_fast_shot(new_value):
	if new_value:
		big_shot = false
		$Aim/Special/Big.visible = false
	
	fast_shot = new_value
	$Aim/Special/Fast.visible = new_value

func _on_enemy_hit():
	if randf() < chance_to_say_something_stupid and not VoiceChannel.blocked:
		body.play_voice(VoiceChannel.ENEMY_HIT)

func _on_round_finished():
	reset()

func _on_ManaTimer_timeout():
	increase_mana(mana_increase)

func _on_pick_up_spawned(impulse):
	# test if impulse is in right distance
	imp = self.global_position - impulse.position
	if imp.length() >= impulse.distance:
		return
	
	# if is, set impulse for this player
	impulse.apply_impulse()
	identity.controll.vibrate(0.9, 0.9, impulse.time / 2)
	$Modifiers.add_child(impulse)

func _on_player_won_round(player):
	if player == self:
		body.play_WinnJump()
		body.play_voice(VoiceChannel.ROUND_WON)

func _on_IndestructableTimer_timeout():
	body.stop_indestructabel()

func FillManaAnimation():
	$AnimationPlayer.play("FillMana")
	
#func EmptyManaAnimationPlay():
	#$AnimationPlayer.play("EmptyMana")
	
#func EmptyManaAnimationStop():
	#$AnimationPlayer.stop("EmptyMana")

func _on_Dodge_timeout():
	identity.controll.active = true
	body.set_motion_blur(false, null)

func _on_player_won_match(player):
	if player == self:
		body.play_voice(VoiceChannel.MATCH_WON)

