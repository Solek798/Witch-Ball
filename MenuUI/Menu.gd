extends ColorRect

# TEMP
export(PackedScene) var main_scene_template
export(PackedScene) var pause_scene_template
export(PackedScene) var tutorial_template

signal tutorial_exited


func _ready():
	pass
	#print(load("res://MenuUI/PauseScreen/PauseScreen.tscn"))
	#add_child(.instance())

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not self.visible:
		pause()

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

func tutorial():
	self.visible = true
	var tutorial = tutorial_template.instance()
	add_child(tutorial)
	
	yield(tutorial.get_node("TimeBeforeTransition"), "timeout")
	self.visible = false
	emit_signal("tutorial_exited")
