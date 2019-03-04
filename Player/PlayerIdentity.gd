extends Object

const LEFT_SIDE = Vector2(1, 1)
const RIGHT_SIDE = Vector2(-1, 1)

var id
var controll
var selection
var side

func _init(id, controll, selection, side):
	self.id = id
	self.controll = controll
	self.selection = selection
	self.side = side
