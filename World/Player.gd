extends KinematicBody2D

export(int) var movementSpeed 


func _ready():
	pass

func _process(delta):
	get_movement(delta)

func get_movement(delta):
	var input = Vector2()
	if Input.is_action_pressed("player1_up"):
		input.y = -1
	if Input.is_action_pressed("player1_down"):
		input.y = 1
	if Input.is_action_pressed("player1_left"):
		input.x = -1
	if Input.is_action_pressed("player1_right"):
		input.x = 1
	
	move_and_collide(input * delta * movementSpeed)
