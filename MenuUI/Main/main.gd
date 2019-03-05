extends CenterContainer

export(String, FILE, "*.tscn") var path_to_own_template

onready var own_template = load(path_to_own_template)


func _ready():
	$Content/C1/Buttons/Start.grab_focus()
	$Animation.play("FadeIn")

func _on_Start_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($Content/C1/Buttons/Start.next_scene, own_template)
		$Animation.play("FadeOut")
		self.queue_free()

func _on_Options_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($Content/C1/Buttons/Options.next_scene, own_template)
		$Animation.play("FadeOut")
		self.queue_free()

func _on_Credits_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($Content/C1/Buttons/Credits.next_scene, own_template)
		$Animation.play("FadeOut")
		self.queue_free()

func _on_Quit_pressed():
	get_tree().quit()
