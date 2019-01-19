extends Node2D

var selection  #Start
var selection1 #Option
var Credits #Credits


func _on_start_pressed():
	selection.visible = true
	self.visible = false
	
	
	
func _on_options_pressed():
	selection1.visible = true
	self.visible = false
	
	
	
func _on_Credits_pressed():
	Credits.visible = true
	self.visible = false

	
func _on_quit_pressed():
	get_tree().quit()

