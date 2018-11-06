extends KinematicBody2D

export(int) var movementSpeed 

enum action {UP, DOWN, LEFT, RIGHT}

# template for action event Strings
var ctr = ["player%d_up", "player%d_down", "player%d_left", "player%d_right"]
var player_id

# formating action event Strings for this Player
func _ready():
	for i in range(ctr.size()):
		ctr[i] = ctr[i] % player_id

func _process(delta):
	get_movement(delta)

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
