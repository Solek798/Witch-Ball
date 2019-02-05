extends Control

var return_scene_template


func _ready():
	$Background/Credits/Menu.grab_focus()

func _on_Menu_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene(return_scene_template, null)
	
	self.queue_free()
