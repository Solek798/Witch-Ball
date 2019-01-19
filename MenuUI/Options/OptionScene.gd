extends Control
var selectionMenu

func _on_Menu_pressed():
	selectionMenu.visible = true
	self.visible = false
