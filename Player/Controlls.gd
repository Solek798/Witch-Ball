extends Object

enum modes {KEYBOARD, CONTROLLER}

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
	"player%d_move"
]

export var prefere_controller_mode = true
export var movement_x_axis = 0
export var movement_y_axis = 1
export var aim_x_axis = 2
export var aim_y_axis = 3
export var movement_tolerance = 0.3

onready var keys = []
onready var locked_states = []
onready var active = true
var mode
var device


# sets up action Strings and decides by which Controll-Mode the Player is controlled
func setup(id):
	connect(id)
	
	if prefere_controller_mode and Input.get_connected_joypads().size() >= id:
		mode = CONTROLLER
		device = id - 1
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
		Action.THROW, Action.DODGE:
			return Input.is_action_just_pressed(keys[action])
		Action.UP, Action.DOWN, Action.LEFT, Action.RIGHT, Action.AIM_UP, Action.AIM_DOWN:
			return Input.is_action_pressed(keys[action])

func get_movement():
	if not active:
		return Vector2(0, 0)
	# TODO
	if locked_states.size() == keys.size():
		return locked_states[Action.MOVE]
	
	var x = 0.0
	var y = 0.0
	
	if mode == CONTROLLER:
		x = Input.get_joy_axis(device, movement_x_axis)
		y = Input.get_joy_axis(device, movement_y_axis)
		
		if x < movement_tolerance and x > -movement_tolerance:
			x = 0
		if y < movement_tolerance and y > -movement_tolerance:
			y = 0
	else:
		if Input.is_action_pressed(keys[Action.UP]):
			y -= 1.0
		if Input.is_action_pressed(keys[Action.DOWN]):
			y += 1.0
		if Input.is_action_pressed(keys[Action.LEFT]):
			x -= 1.0
		if Input.is_action_pressed(keys[Action.RIGHT]):
			x += 1.0
	
	return Vector2(x, y)

func get_aim():
	if not active:
		return Vector2(0, 0)
	# TODO
	if locked_states.size() == keys.size():
		return locked_states[Action.AIM]
	
	var aim = Vector2(0, 0)
	
	if mode == CONTROLLER:
		aim.x = Input.get_joy_axis(device, aim_x_axis)
		# TEMP
		if device == 1:
			aim.x *= -1
		aim.y = Input.get_joy_axis(device, aim_y_axis)
		# Workaround for inaccurate Controller Input
		if aim.x < 0.01 and aim.x > -0.01:
			aim.x = 0
		if aim.y < 0.01 and aim.y > -0.01:
			aim.y = 0
	else:
		if Input.is_action_pressed(keys[Action.AIM_UP]):
			aim.y -= DEGREE_IN_RADIANT
		if Input.is_action_pressed(keys[Action.AIM_DOWN]):
			aim.y += DEGREE_IN_RADIANT
	
	return aim

# locks the player Input to current state
func lock():
	for a in Action.action.values():
		locked_states.append(state(a))

# unlocks the Player Input
func unlock():
	locked_states.clear()

func _on_DodgeTimer_timeout():
	unlock()

