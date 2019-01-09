extends KinematicBody2D

export(PackedScene) var bullet_template
export(PackedScene) var bullet_fast_template
export(PackedScene) var bullet_big_template
export(int) var movement_speed 
export(float) var aim_speed
export(int) var bullet_speed
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
var next_bullet
onready var health = max_health
onready var is_dead = false
onready var won_rounds = 0
# TEMP
var throw_vector

func _ready():
	$Controlls.setup(id)
	$Mana.max_value = max_mana
	$Mana.value = start_mana
	next_bullet = bullet_template
	
	if id % 2 == 0:
		throw_vector = Vector2(-1, 0)
	else:
		throw_vector = Vector2(1, 0)
	
	emit_signal("player_created", self)

func _process(delta):
	var movement = $Controlls.get_movement()
	
	if movement:
		$Scarlet.play_walk()
		$Smoke.emitting = true
	else:
		$Scarlet.stop_walk()
		$Smoke.emitting = false
	
	# sets dodge-multiplier if player is dodging
	# TEMP!
	var mult = 1
	if $DodgeTimer.time_left > 0:
		mult = dodge_multiplier
	
	# moves player and scans for collisions
	move_and_slide(movement * movement_speed * mult)
	
	# calculates the rotation in this frame and rotates the aim pointer
	var direction = $Controlls.get_aim()
	var aim = atan2(direction.y, direction.x)
	$Aim.rotation = aim
	
	if $Controlls.state(Action.THROW):
		throw(movement)
	if $Controlls.state(Action.DODGE):
		dodge(movement)

func throw(movement):
	# Don't throw while ThrowTimer is running or while you have no mana
	if $ThrowTimer.time_left > 0 or $Mana.value < throw_mana:
		return
	
	# calculates throm impuls
	var player_position = self.global_position
	var throw_point_position = $Scarlet.get_throw_point()
	#var impulse = (throw_point_position - player_position) * bullet_speed
	
	
	# instanciates and sets a new bullet to thropoint position
	var bullet = next_bullet.instance()
	bullet.position = throw_point_position
	bullet.own_player = self
	var impulse = throw_vector.rotated($Aim.rotation) * bullet.speed
	
	# throw the bullet
	bullet.apply_impulse(throw_point_position, impulse)
	$Mana.value -= throw_mana
	
	# start Timer for throw delay
	$ThrowTimer.start()
	$Scarlet.play_throw(movement)
	emit_signal("bullet_thrown", bullet)

func dodge(movement):
	if movement == Vector2(0, 0) or $Mana.value < dodge_mana:
		return
	
	# if player is not allready dodging, he starts to dodge
	if $DodgeTimer.is_stopped():
		$Mana.value -= dodge_mana
		$Controlls.lock()
		$DodgeTimer.start()
		$Scarlet.play_dodge_down()
		$AinimationTween.interpolate_callback($Scarlet, dodge_up_time, "play_dodge_up")

func take_damage(ammount):
	if is_dead:
		return
	$Scarlet.play_hit()
	health -= ammount
	emit_signal("player_damaged", self, ammount)
	
	if health <= 0:
		$Controlls.active = false
		is_dead = true
		emit_signal("player_died", self)

func reset():
	# all values that could have been changed are reset to default
	health = max_health
	$Aim.rotation = 0
	$Controlls.active = true
	is_dead = false
	emit_signal("player_reseted", self)

func _on_round_finished():
	reset()

func _on_DodgeTimer_timeout():
	$Scarlet.play_dodge_up()


func _on_ManaTimer_timeout():
	$Mana.value += mana_increase
