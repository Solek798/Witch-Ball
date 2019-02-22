extends ColorRect

# TEMP
export(PackedScene) var main_scene_template
export(PackedScene) var pause_scene_template
export(PackedScene) var tutorial_template

signal tutorial_exited
signal restart_requested
signal stop_requested

onready var manage_input = true
onready var current_controll = get_parent().get_node("Controlls1")


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not self.visible:
		pause()
	
	if manage_input:
		manage_input()

func open(manage_input=true):
	self.visible = true
	self.manage_input = manage_input

func close(manage_input=false):
	self.manage_input = manage_input
	self.visible = false

func set_blur(amount, darknes):
	self.material.set_shader_param("amount", amount)
	self.material.set_shader_param("darknes", darknes)

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

func request_restart():
	emit_signal("restart_requested")

func request_stop():
	emit_signal("stop_requested")

func menu():
	open()
	set_blur(2.5, 0.0)
	add_child(main_scene_template.instance())

func pause():
	open()
	set_blur(2.5, 0.25)
	add_child(pause_scene_template.instance())

func tutorial():
	if ProjectSettings.get_setting("Witch-Ball/Tutorial"):
		open(false)
		set_blur(2.5, 0.25)
		var tutorial = tutorial_template.instance()
		add_child(tutorial)
		
		yield(tutorial.get_node("TimeBeforeTransition"), "timeout")
		close()
	
	emit_signal("tutorial_exited")

func manage_input():
	var event
	
	if current_controll.state(Action.MENU_UP):
		event = "ui_up"
		#focus_owner.get_node(focus_owner.focus_neighbour_top).grab_focus()
	if current_controll.state(Action.MENU_DOWN):
		event = "ui_down"
		#focus_owner.get_node(focus_owner.focus_neighbour_bottom).grab_focus()
	if current_controll.state(Action.MENU_LEFT):
		event = "ui_left"
		#focus_owner.get_node(focus_owner.focus_neighbour_left).grab_focus()
	if current_controll.state(Action.MENU_RIGHT):
		event = "ui_right"
		#focus_owner.get_node(focus_owner.focus_neighbour_right).grab_focus()
	
	if event != null:
		var act = InputEventAction.new()
		act.action = event
		act.pressed = true
		Input.parse_input_event(act)

