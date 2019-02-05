extends Control

export(String, FILE, "*.tscn") var path_to_own_template

onready var own_template = load(path_to_own_template)


func _ready():
	$Content/Buttons/Options.grab_focus()

func _on_Options_pressed():
	if get_parent().has_method("switch_scene"):
		get_parent().switch_scene($Content/Buttons/Options.next_scene, own_template)
