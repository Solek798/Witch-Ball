extends Object

const LEFT_SIDE = Vector2(1, 1)
const RIGHT_SIDE = Vector2(-1, 1)

var id
var controlls
var selection
var side

func _init(id, controlls, selection, side):
	self.id = id
	self.controlls = controlls
	self.selection = selection
	self.side = side
