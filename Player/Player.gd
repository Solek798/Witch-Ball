extends KinematicBody2D

export(PackedScene) var bullet_template
export(int) var movement_speed 
export(int) var aim_speed
export(int) var bullet_speed
export(int) var max_health
export(float) var dodge_multiplier

signal bullet_thrown(bullet)
signal player_damaged(player, ammount)
signal player_died(player)
signal player_reseted(player)


onready var player_controller_class = preload("res://Player/PlayerController.gd")

var controlls
var id
var health

func _ready():
	controlls = player_controller_class.new()
	controlls.setup(id)
	health = max_health
	emit_signal("player_created", self)

func _process(delta):
	var movement = controlls.get_movement()
	
	# sets dodge-multiplier if player is dodging
	var mult = 1
	if $DodgeTimer.time_left > 0:
		mult = dodge_multiplier
	# moves player and scans for collisions
	move_and_slide(movement * movement_speed * mult)
	
	# rotates aim pointer
	var direction = controlls.get_aim()
	#print(direction)
	var aim = -(direction.angle_to(Vector2(1, 0).rotated($Aim.rotation)))
	$Aim.rotate(aim * delta * aim_speed)
	
	if controlls.state(Action.THROW):
		throw()
	if controlls.state(Action.DODGE):
		dodge(movement)

func throw():
	var player_position = self.global_position
	var throw_point_position = $Aim/throw_point.global_position
	var impulse = (throw_point_position - player_position) * bullet_speed
	
	# instanciates and sets a new bullet to thropoint position
	var bullet = bullet_template.instance()
	bullet.position = throw_point_position
	
	bullet.apply_impulse(throw_point_position, impulse)
	emit_signal("bullet_thrown", bullet)

func dodge(movement):
	if movement == Vector2(0, 0):
		return
	
	# if player is not allready dodging, he starts to dodge
	if $DodgeTimer.is_stopped():
		controlls.lock()
		$DodgeTimer.start()

func take_damage(ammount):
	health -= ammount
	emit_signal("player_damaged", self, ammount)
	
	if health <= 0:
		controlls.lock()
		emit_signal("player_died", self)

func reset():
	# all values that could have been changed are reset to default
	health = max_health
	$Aim.rotation = 0
	controlls.unlock()
	emit_signal("player_reseted", self)

func _on_round_finished():
	reset()

func _on_DodgeTimer_timeout():
	controlls.unlock()
