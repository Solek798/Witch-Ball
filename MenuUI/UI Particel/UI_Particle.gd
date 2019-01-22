extends Node2D

func _on_start_mouse_entered():
	visible = true
func _on_start_mouse_exited():
	visible = false
func _on_start_pressed():
	_on_start_mouse_exited()


func _on_options_mouse_entered():	
	visible = true
func _on_options_mouse_exited():	
	visible = false
func _on_options_pressed():
	_on_options_mouse_exited()


func _on_Credits_mouse_entered():
	visible = true
func _on_Credits_mouse_exited():	
	visible = false
func _on_Credits_pressed():
	_on_start_mouse_exited()


func _on_quit_mouse_entered():	
	visible = true
func _on_quit_mouse_exited():	
	visible = false


