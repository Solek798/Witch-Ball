extends KinematicBody2D

export(int) var movementSpeed 

enum action {UP, DOWN, LEFT, RIGHT, AIM_UP, AIM_DOWN, THROW}

const DEGREE_IN_RADIANT = PI / 180

# template for action event Strings
var ctr 
var player_id

# formating action event Strings for this Player
func _ready():
	ctr= [
		"player%d_up", 
		"player%d_down", 
		"player%d_left", 
		"player%d_right",
		"player%d_aim_up",
		"player%d_aim_down",
		"player%d_throw"
	]
	
	for i in range(ctr.size()):
		ctr[i] = ctr[i] % player_id

func _process(delta):
	get_movement(delta)
	get_aim()

func get_movement(delta):
	var input = Vector2()
	
	if Input.is_action_pressed(ctr[UP]):
		input.y -= 1
	if Input.is_action_pressed(ctr[DOWN]):
		input.y += 1
	if Input.is_action_pressed(ctr[LEFT]):
		input.x -= 1
	if Input.is_action_pressed(ctr[RIGHT]):
		input.x += 1
	
	move_and_collide(input * delta * movementSpeed)

func get_aim():
	var input = 0
	if Input.is_action_pressed(ctr[AIM_UP]):
		input.x += 1
	if Input.is_action_pressed(ctr[AIM_DOWN]
	
	


