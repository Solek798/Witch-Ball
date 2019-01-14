extends Node2D

var selection


func _on_start_pressed():
	selection.visible = true
	self.visible = false

func _on_quit_pressed():
	get_tree().quit()
