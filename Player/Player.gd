extends KinematicBody2D

export(PackedScene) var bullet_template
export(int) var movement_speed 
export(int) var aim_speed
export(int) var bullet_speed
export(int) var max_health
export(float) var dodge_multiplier

signal bullet_thrown(bullet)
signal player_created(player)
signal player_damaged(player, ammount)
signal player_dead(player)
signal player_reset(player)

enum action {UP, DOWN, LEFT, RIGHT, AIM_UP, AIM_DOWN, THROW, DODGE}

const DEGREE_IN_RADIANT = PI / 180

var id
var health

func _ready():
	$PlayerController.setup(id)
	health = max_health
	emit_signal("player_created", self)

func _process(delta):
	var movement = get_movement()
	
	# sets dodge-multiplier if player is dodging
	var mult = 1
	if $DodgeTimer.time_left > 0:
		mult = dodge_multiplier
	
	# moves player and scans for collisions
	move_and_collide(movement * delta * movement_speed * mult)
	
	# rotates aim pointer
	var aim = get_aim()
	$Aim.rotate(aim * delta * aim_speed)
	
	if $PlayerController.state(THROW):
		throw()
	if $PlayerController.state(DODGE):
		dodge(movement)
	

func get_movement():
	var movement = Vector2()
	
	if $PlayerController.state(UP):
		movement.y -= 1
	if $PlayerController.state(DOWN):
		movement.y += 1
	if $PlayerController.state(LEFT):
		movement.x -= 1
	if $PlayerController.state(RIGHT):
		movement.x += 1
	
	return movement

func get_aim():
	var aim = 0
	
	if $PlayerController.state(AIM_UP):
		aim -= DEGREE_IN_RADIANT
	if $PlayerController.state(AIM_DOWN):
		aim += DEGREE_IN_RADIANT
	
	return aim

func throw():
	# instanciates and sets a new bullet to thropoint position
	var bullet = bullet_template.instance()
	bullet.position = $Aim/throw_point.global_position
	
	# creates velocity for the bullet based on its position to the player
	var velocity = $Aim/throw_point.position.normalized()
	velocity = velocity.rotated($Aim.rotation)
	velocity = velocity * bullet_speed
	
	# throws bullet
	bullet.linear_velocity = velocity
	emit_signal("bullet_thrown", bullet)

func dodge(movement):
	if movement == Vector2(0, 0):
		return
	
	# if player is not allready dodging, he starts to dodge
	if $DodgeTimer.is_stopped():
		$PlayerController.lock()
		$DodgeTimer.start()

func take_damage(ammount):
	health -= ammount
	emit_signal("player_damaged", self, ammount)
	
	if health <= 0:
		$PlayerController.lock()
		emit_signal("player_dead", self)

func reset():
	# all values that could have been changed are reset to default
	health = max_health
	$Aim.rotation = 0
	$PlayerController.unlock()
	emit_signal("player_reset", self)
