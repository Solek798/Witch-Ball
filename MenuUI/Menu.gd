extends ColorRect

# TEMP
export(PackedScene) var main_scene_template
export(PackedScene) var pause_scene_template
export(PackedScene) var tutorial_template

signal tutorial_exited

onready var manage_input = true
onready var current_controll = get_parent().get_node("Controlls1")


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not self.visible:
		pause()
	if manage_input:
		manage_input()

func open():
	self.visible = true
	manage_input = true

func close():
	manage_input = false
	self.visible = false

func switch_scene(next_scene_template, return_scene):
	if not next_scene_template:
		return
	var new_scene = next_scene_template.instance()
	if return_scene:
		new_scene.return_scene_template = return_scene
	add_child(new_scene)

func confirm_selection(selection):
	close()
	get_parent().start_match(selection)

func menu():
	open()
	add_child(main_scene_template.instance())

func pause():
	open()
	add_child(pause_scene_template.instance())

func tutorial():
	open()
	var tutorial = tutorial_template.instance()
	add_child(tutorial)
	
	yield(tutorial.get_node("TimeBeforeTransition"), "timeout")
	close()
	emit_signal("tutorial_exited")

func manage_input():
	var focus_owner = self.get_focus_owner()
	
	if current_controll.state(Action.MENU_UP):
		focus_owner.get_node(focus_owner.focus_neighbour_top).grab_focus()
	if current_controll.state(Action.MENU_DOWN):
		focus_owner.get_node(focus_owner.focus_neighbour_bottom).grab_focus()
	if current_controll.state(Action.MENU_LEFT):
		focus_owner.get_node(focus_owner.focus_neighbour_left).grab_focus()
	if current_controll.state(Action.MENU_RIGHT):
		focus_owner.get_node(focus_owner.focus_neighbour_right).grab_focus()

