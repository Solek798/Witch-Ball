extends TextureButton

export(PackedScene) var next_scene
export(PackedScene) var particle_template
export(PackedScene) var text_template
export(PackedScene) var Amimation_Character_Selection_template

# TEMP
var current_part
var current_text


func _on_MagicButton_focus_entered():
	if particle_template:
		current_part = particle_template.instance()
		add_child(current_part)
	if text_template:
		current_text = text_template.instance()
		add_child(current_text)
	
	if Amimation_Character_Selection_template:
		current_part = Amimation_Character_Selection_template.instance()
		add_child(current_part)

func _on_MagicButton_focus_exited():
	if current_part:
		current_part.queue_free()
	if current_text:
		current_text.queue_free()

func _on_MagicButton_mouse_entered():
	self.grab_focus()

func _on_MagicButton_pressed():
	MenuSound.play()
