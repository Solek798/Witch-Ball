extends KinematicBody2D

export(PackedScene) var projectile_template
export(int) var movement_speed 
export(int) var aim_speed
export(int) var projectile_speed

signal projectile_thrown(node)

enum action {UP, DOWN, LEFT, RIGHT, AIM_UP, AIM_DOWN, THROW, DODGE}

const DEGREE_IN_RADIANT = PI / 180

var player_id


func _ready():
	$PlayerController.setup(player_id)

func _process(delta):
	var movement = get_movement()
	move_and_collide(movement * delta * movement_speed)
	
	var aim = get_aim()
	$Aim.rotate(aim * delta * aim_speed)
	
	if $PlayerController.state(THROW):
		throw(movement)
	

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

func throw(current_movement):
	var projectile = projectile_template.instance()
	projectile.position = $Aim/throw_point.global_position
	
	var velocity = $Aim/throw_point.position.normalized().rotated($Aim.rotation)
	velocity = velocity*projectile_speed + current_movement*movement_speed
	
	projectile.linear_velocity = velocity
	emit_signal("projectile_thrown", projectile)

