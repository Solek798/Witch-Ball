extends CenterContainer


func _ready():
	$content/C1/buttons/Start.grab_focus()

func _on_Start_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($content/C1/buttons/Start.next_scene)
	self.queue_free()

func _on_options_pressed():
	print("options")

func _on_Credits_pressed():
	print("credits")

func _on_quit_pressed():
	print("quit")

