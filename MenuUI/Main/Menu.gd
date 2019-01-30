extends Control

func _ready():
	$Main/content/C1/buttons/start.connect("pressed", self, "_on_start_pressed")
	$Main/content/C1/buttons/options.connect("pressed", self, "_on_options_pressed")
	$Main/content/C1/buttons/Credits.connect("pressed", self, "_on_credits_pressed")
	$Characterselection.connect("match_instantiated", self, "_on_match_instantiated")
	$Credits/Menu.connect("pressed", self, "_on_menu_pressed")
	$PauseScreen/Content/N1/C1/Buttons/options.connect("pressed", self, "_on_options_pressed")
	$PauseScreen/Content/N1/C1/Buttons/Resume.connect("pressed", self, "_on_resume_pressed")
	$PauseScreen/Content/N1/C1/Buttons/Restart.connect("pressed", self, "_on_restart_pressed")
	$PauseScreen/Content/N1/C1/Buttons/Cancel.connect("pressed", self, "_on_cancel_pressed")

func _on_start_pressed():
	$Main.visible = false
	$PauseScreen.visible = true

func _on_options_pressed():
	Main.visible = false
	$PauseScreen.visible = false
	$OptionScene.visible = true

func _on_credits_pressed():
	pass

func _on_menu_pressed():
	pass

func _on_resume_pressed():
	pass

func _on_restart_pressed():
	pass

func _on_cancel_pressed():
	pass
