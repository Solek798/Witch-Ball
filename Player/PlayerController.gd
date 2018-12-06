extends Object

enum modes {KEYBOARD, CONTROLLER}

# TODO
const DEGREE_IN_RADIANT = PI / 180
const MOVEMENT_X_AXIS = 0
const MOVEMENT_Y_AXIS = 1
const AIM_X_AXIS = 2
const AIM_Y_AXIS = 3
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

# TODO
var mode
var keys
var locked_states
var device

# TODO
func setup(id, prefere_controller_mode=true):
	keys = []
	locked_states = []
	
	connect(id)
	
	if prefere_controller_mode and Input.get_connected_joypads().size() >= id:
		mode = CONTROLLER
		device = id - 1
	else:
		mode = KEYBOARD

func connect(id):
	for string in FORMAT_STRINGS:
		keys.append(string % id)

# TODO
func state(action):
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
	var x = 0.0
	var y = 0.0
	
	if mode == CONTROLLER:
		x = Input.get_joy_axis(device, MOVEMENT_X_AXIS)
		y = Input.get_joy_axis(device, MOVEMENT_Y_AXIS)
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
	var aim = Vector2(0, 0)
	
	if mode == CONTROLLER:
		aim.x = Input.get_joy_axis(device, AIM_X_AXIS)
		aim.y = Input.get_joy_axis(device, AIM_Y_AXIS)
		
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

# TODO
func _on_DodgeTimer_timeout():
	unlock()

