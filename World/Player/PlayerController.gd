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

var keys = []

func setup(id):
	keys.clear()
	
	for string in FORMAT_STRINGS:
		keys.append(string % id)

func state(action):
	if action > 5:
		return Input.is_action_just_pressed(keys[action])
	else:
		return Input.is_action_pressed(keys[action])
	
