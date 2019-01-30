extends CenterContainer

signal main_exited(next_scene)


func _ready():
	$VBoxContainer/CenterContainer/VBoxContainer/start.focus_mode = Control.FOCUS_ALL

func _on_start_pressed():
	emit_signal("main_exited", Action.CHARACTER_SELECTION)
	self.queue_free()

func _on_options_pressed():
	print("options")

func _on_Credits_pressed():
	print("credits")

func _on_quit_pressed():
	print("quit")
