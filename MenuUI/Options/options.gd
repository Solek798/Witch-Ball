extends CenterContainer

var return_scene_template


func _ready():
	
	$Panel/Conent/Buttons/Menu.grab_focus()
	$Panel/Conent/Options/VB1/HB1/FullScreen.pressed = OS.window_fullscreen
	$Panel/Conent/Options/VB1/HB2/Tutorial.pressed = ProjectSettings.get_setting("Witch-Ball/Tutorial")
	$Panel/Conent/Options/VB1/Sound.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"))
	$Panel/Conent/Options/VB1/Sound.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"))
	$Animation.play("FadeIn")

func _on_Menu_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene(return_scene_template, null)
		$Animation.play("FadeOut")
	self.queue_free()

func _on_FullScreen_pressed():
	#print(ProjectSettings.has_setting("Display/Window/size/Fullscreen"))
	OS.window_fullscreen = $Panel/Conent/Options/VB1/HB1/FullScreen.pressed

func _on_Tutorial_pressed():
	ProjectSettings.set_setting("Witch-Ball/Tutorial", 
								$Panel/Conent/Options/VB1/HB2/Tutorial.pressed)

func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), value)

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)



func _on_Animirtes_Tutorial_pressed():
	$AnimirtesTutorial.visible = true
	print("1")
	$AnimirtesTutorial/Tutorial/Buttons/Options.grab_focus()
	print("2")
	$Panel.visible = false
	pass # replace with function body


func _on_Options_pressed():
	
	$Panel.visible = true
	$AnimirtesTutorial.visible = false
	$Panel/Conent/Buttons/Menu.grab_focus()
	pass # replace with function body
