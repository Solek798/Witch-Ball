extends Object

enum modes {KEYBOARD, CONTROLLER}
enum analog_stick {LEFT, RIGHT}

const DEGREE_IN_RADIANT = PI / 180
const FORMAT_STRINGS = [
	"player%d_up", 
	"player%d_down", 
	"player%d_left", 
	"player%d_right",
	"player%d_aim_up",
	"player%d_aim_down",
	"player%d_throw",
	"player%d_dodge",
	"player%d_aim",
	"player%d_move",
	"player%d_throw_special"
]

export var prefere_controller_mode = true
export var movement_x_axis = 0
export var movement_y_axis = 1
export var aim_x_axis = 2
export var aim_y_axis = 3
export var movement_tolerance = 0.3
export var aim_tolerance = 0.3

onready var keys = []
onready var locked_states = []
onready var active = true
var mode
var device


# sets up action Strings and decides by which Controll-Mode the Player is controlled
func setup(id):
	connect(id + 1)
	
	if prefere_controller_mode and Input.get_connected_joypads().size() >= id + 1:
		mode = CONTROLLER
		device = id
	else:
		mode = KEYBOARD

func connect(id):
	for string in FORMAT_STRINGS:
		keys.append(string % id)

# gets the state or vales of the given action
func state(action):
	if not active:
		return 0
	
	if locked_states.size() == keys.size():
		return locked_states[action]
	
	match action:
		Action.MOVE:
			return get_movement()
		Action.AIM:
			return get_aim()
		Action.THROW, Action.DODGE, Action.THROW_SPECIAL:
			return Input.is_action_just_pressed(keys[action])
		Action.UP, Action.DOWN, Action.LEFT, Action.RIGHT, Action.AIM_UP, Action.AIM_DOWN:
			return Input.is_action_pressed(keys[action])

func get_movement():
	if not active:
		return Vector2(0, 0)
	# TODO
	print(locked_states.size())
	print(keys.size())
	if locked_states.size() == keys.size():
		return locked_states[Action.MOVE]
	
	var movement = Vector2(0, 0)
	
	if mode == CONTROLLER:
		movement = get_controller_input(LEFT)
	else:
		if Input.is_action_pressed(keys[Action.UP]):
			movement.y -= 1.0
		if Input.is_action_pressed(keys[Action.DOWN]):
			movement.y += 1.0
		if Input.is_action_pressed(keys[Action.LEFT]):
			movement.x -= 1.0
		if Input.is_action_pressed(keys[Action.RIGHT]):
			movement.x += 1.0
	
	return movement

func get_aim():
	if not active:
		return Vector2(0, 0)
	# TODO
	if locked_states.size() == keys.size():
		return locked_states[Action.AIM]
	
	var aim = Vector2(0, 0)
	
	if mode == CONTROLLER:
		aim = get_controller_input(RIGHT)
		# TEMP
		if device == 1:
			aim.x *= -1
	else:
		if Input.is_action_pressed(keys[Action.AIM_UP]):
			aim.y -= DEGREE_IN_RADIANT
		if Input.is_action_pressed(keys[Action.AIM_DOWN]):
			aim.y += DEGREE_IN_RADIANT
	
	return aim

func get_controller_input(stick):
	var input = Vector2(0, 0)
	var x_axis
	var y_axis
	
	if stick == LEFT:
		x_axis = 0
		y_axis = 1
	else:
		x_axis = 2
		y_axis = 3
	
	input.x = Input.get_joy_axis(device, x_axis)
	input.y = Input.get_joy_axis(device, y_axis)
	
	if input.length() < aim_tolerance:
		input.x = 0
		input.y = 0
	
	return input

# locks the player Input to current state
func lock():
	for a in Action.action.values():
		locked_states.append(state(a))

# unlocks the Player Input
func unlock():
	locked_states.clear()

func _on_DodgeTimer_timeout():
	unlock()

