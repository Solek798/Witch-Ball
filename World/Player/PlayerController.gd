extends Node

const FORMAT_STRINGS = [
	"player%d_up", 
	"player%d_down", 
	"player%d_left", 
	"player%d_right",
	"player%d_aim_up",
	"player%d_aim_down",
	"player%d_throw",
	"player%d_dodge"
]

onready var keys = []
onready var locked_states = []

func setup(id):
	for string in FORMAT_STRINGS:
		keys.append(string % id)

func state(action):
	if locked_states.size() > 0:
		return locked_states[action]
	
	if action > 5:
		return Input.is_action_just_pressed(keys[action])
	else:
		return Input.is_action_pressed(keys[action])
	

func lock():
	for key in keys:
		locked_states.append(Input.is_action_pressed(key))

func unlock():
	locked_states.clear()

func _on_DodgeTimer_timeout():
	unlock()
