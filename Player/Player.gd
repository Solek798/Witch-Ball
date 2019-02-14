extends KinematicBody2D

export(PackedScene) var bullet_template
export(PackedScene) var bullet_fast_template
export(PackedScene) var bullet_big_template
export(int) var movement_speed 
export(float) var aim_speed
export(int) var max_health
export(float) var dodge_multiplier
export(int) var max_mana
export(int) var start_mana
export(int) var throw_mana
export(int) var dodge_mana
export(int) var mana_increase
# TEMP
export(float) var dodge_up_time

signal bullet_thrown(bullet)
signal player_damaged(player, ammount)
signal player_died(player)
signal player_reseted(player)

var id
var selection
var body
var controll
var next_bullet
onready var modifiers = []
onready var health = max_health
onready var is_dead = false
onready var fast_shot = false setget set_fast_shot
onready var big_shot = false setget set_big_shot
onready var won_rounds = 0
# TEMP
var throw_vector
var imp

func _ready():
	body = selection.instance()
	add_child(body)
	$Mana.max_value = max_mana
	$Mana.value = start_mana
	next_bullet = bullet_template
	
	if id % 2 == 0:
		throw_vector = Vector2(-1, 0)
	else:
		throw_vector = Vector2(1, 0)
	
	emit_signal("player_created", self)

func _process(delta):
	# TEMP!
	# Cheat-shortcuts are going to be removed in final Version
	if Input.is_action_just_pressed("cheat_fast_bullet"):
		self.fast_shot = true
	if Input.is_action_just_pressed("cheat_big_bullet"):
		self.big_shot = true
	
	var movement = controll.get_movement()
	
	if movement:
		body.play_walk()
		$Smoke.emitting = true
	else:
		body.stop_walk()
		$Smoke.emitting = false
	
	for mod in modifiers:
		movement += imp * mod.get_strength()
	
	# sets dodge-multiplier if player is dodging
	# TEMP!
	var mult = 1
	if $DodgeTimer.time_left > 0:
		mult = dodge_multiplier
	
	# moves player and scans for collisions
	move_and_slide(movement * movement_speed * mult)
	
	# calculates the rotation in this frame and rotates the aim pointer
	var direction = controll.get_aim()
	var aim = atan2(direction.y, direction.x)
	$Aim.rotation = aim
	
	if controll.state(Action.THROW):
		throw(movement)
	if controll.state(Action.DODGE):
		dodge(movement)
	if controll.state(Action.THROW_SPECIAL):
		if fast_shot:
			next_bullet = bullet_fast_template
			throw(movement)
		if big_shot:
			next_bullet = bullet_big_template
			throw(movement)

func throw(movement):
	# Don't throw while ThrowTimer is running or while you have no mana
	if $ThrowTimer.time_left > 0 or $Mana.value < throw_mana:
		if $Mana.value < throw_mana:
			controll.vibrate(0.7, 0.2, 0.3)
		return
	
	# calculates throm impuls
	var player_position = self.global_position
	var throw_point_position = body.get_throw_point()
	
	
	# instanciates and sets a new bullet to thropoint position
	var bullet = next_bullet.instance()
	bullet.position = throw_point_position
	bullet.own_player = self
	var impulse
	if id % 2 == 0:
		impulse = throw_vector.rotated(-$Aim.rotation) * bullet.speed
	else:
		impulse = throw_vector.rotated($Aim.rotation) * bullet.speed
	
	# throw the bullet
	bullet.apply_impulse(throw_point_position, impulse)
	$Mana.value -= throw_mana
	
	if next_bullet != bullet_template:
		next_bullet = bullet_template
		set_fast_shot(false)
		set_big_shot(false)
	
	# start Timer for throw delay
	$ThrowTimer.start()
	body.play_throw(movement)
	emit_signal("bullet_thrown", bullet)

func dodge(movement):
	if movement == Vector2(0, 0) or $Mana.value < dodge_mana:
		return
	
	# if player is not allready dodging, he starts to dodge
	if $DodgeTimer.is_stopped():
		$Mana.value -= dodge_mana
		controll.lock()
		$DodgeTimer.start()
		body.play_dodge_down()
		$AinimationTween.interpolate_callback(body, dodge_up_time, "play_dodge_up")

func take_damage(ammount):
	if is_dead or $IndestructableTimer.time_left:
		return
	
	body.play_hit()
	$IndestructableTimer.start()
	health -= ammount
	controll.vibrate(0.6, 0.6, 0.2)
	emit_signal("player_damaged", self, ammount)
	
	if health <= 0:
		controll.active = false
		is_dead = true
		emit_signal("player_died", self)

func reset():
	# all values that could have been changed are reset to default
	health = max_health
	$Mana.value = start_mana
	$Aim.rotation = 0
	controll.active = true
	is_dead = false
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

func _on_round_finished():
	reset()

func _on_DodgeTimer_timeout():
	body.play_dodge_up()

func _on_ManaTimer_timeout():
	increase_mana(mana_increase)

func _on_pick_up_spawned(impulse, position):
	var length = (self.global_position - position).length()
	var diff = impulse.distance - length
	imp = self.global_position - position
	if imp.length() >= impulse.distance:
		return 
	imp /= imp.length() * (impulse.distance / diff)
	
	impulse.apply_impulse()
	controll.vibrate(0.9, 0.9, impulse.time / 2)
	modifiers.append(impulse)

func _on_player_won_round():
	body.play_WinnJump()

func _on_IndestructableTimer_timeout():
	body.stop_indestructabel()


func _on_Timer_timeout():
	Input.action_press("player1_down")
	yield(get_tree(), "idle_frame")
	Input.action_release("player1_down")
