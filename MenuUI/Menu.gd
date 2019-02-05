extends Control

# TEMP
export(PackedScene) var main_scene_template
export(PackedScene) var pause_scene_template


func _ready():
	pass
	#print(load("res://MenuUI/PauseScreen/PauseScreen.tscn"))
	#add_child(.instance())

func switch_scene(next_scene_template, return_scene):
	if not next_scene_template:
		return
	var new_scene = next_scene_template.instance()
	if return_scene:
		new_scene.return_scene_template = return_scene
	add_child(new_scene)

func confirm_selection(selection):
	self.visible = false
	get_parent().start_match(selection)

func menu():
	self.visible = true
	add_child(main_scene_template.instance())

func pause():
	self.visible = true
	add_child(pause_scene_template.instance())