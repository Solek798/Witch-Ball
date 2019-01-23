extends Node2D

var selection  #Start
var selection1 #Option
var Credits #Credits
var selectionMenu

func _on_Menu_pressed():					#vOption
	selectionMenu.visible = true
	self.visible = false


func _on_start_pressed():					
	selection.visible = true
	self.visible = false
	
func _on_options_pressed():					#vOption
	selection1.visible = true
	self.visible = false
	

func _on_Credits_pressed():
	Credits.visible = true
	self.visible = false
	
func _on_quit_pressed():
	get_tree().quit()
	
	
	
func _on_Resume_pressed():					#vPause
	pass # replace with function body
func _on_Restart_pressed():					#vPause
	pass # replace with function body


func _on_Cancel_pressed():					#vPause
	pass # replace with function body
