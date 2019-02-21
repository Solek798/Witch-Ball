extends CenterContainer

export(String, FILE, "*.tscn") var path_to_own_template

onready var own_template = load(path_to_own_template)


func _ready():
	get_tree().paused = true
	$Background/Content/Buttons/Resume.grab_focus()

func _on_Options_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($Background/Content/Buttons/Options.next_scene, own_template)

func _on_Resume_pressed():
	if get_parent().has_method("close"):
		get_parent().close()
	self.queue_free()
	get_tree().paused = false

func _on_Restart_pressed():
	if get_parent().has_method("request_restart"):
		get_parent().request_restart()
	if get_parent().has_method("close"):
		get_parent().close()
	self.queue_free()
	get_tree().paused = false
