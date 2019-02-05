extends CenterContainer

var return_scene_template


func _ready():
	$Conent/Menu.grab_focus()

func _on_Menu_pressed():
	if get_parent().has_method("switch_scene"):
		print(return_scene_template)
		get_parent().switch_scene(return_scene_template, null)
	self.queue_free()
