extends Node2D

func _on_start_mouse_entered():					#Menu
	visible = true
func _on_start_mouse_exited():
	visible = false
func _on_start_pressed():
	_on_start_mouse_exited()


func _on_options_mouse_entered():				#Menu
	visible = true
func _on_options_mouse_exited():	
	visible = false
func _on_options_pressed():
	_on_options_mouse_exited()


func _on_Credits_mouse_entered():				#Menu
	visible = true
func _on_Credits_mouse_exited():	
	visible = false
func _on_Credits_pressed():
	_on_start_mouse_exited()


func _on_quit_mouse_entered():					#Menu
	visible = true
func _on_quit_mouse_exited():	
	visible = false


func _on_Menu_mouse_entered():					#OptionScene
	visible = true
func _on_Menu_mouse_exited():
	visible = false
func _on_Menu_pressed():
	_on_Menu_mouse_exited()



func _on_Resume_mouse_entered():				#Pause
	visible = true
func _on_Resume_mouse_exited():
	visible = false
func _on_Resume_pressed():
	_on_Resume_mouse_exited()



func _on_Restart_mouse_entered():				#Pause
	visible = true
func _on_Restart_mouse_exited():
	visible = false
func _on_Restart_pressed():
	_on_Restart_mouse_exited()



func _on_Cancel_mouse_entered():				#Pause
	visible = true
func _on_Cancel_mouse_exited():
	visible = false
func _on_Cancel_pressed():
	_on_Cancel_mouse_exited()
