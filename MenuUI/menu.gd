extends ColorRect

export(PackedScene) var main_scene_template
export(PackedScene) var pause_scene_template
export(PackedScene) var tutorial_template
export(PackedScene) var versus_template

signal intro_finished
signal restart_requested
signal stop_requested

onready var manage_input = true
var controlls
var current_controll


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not self.visible:
		pause()
	
	if manage_input:
		manage_input()

func open(manage_input=true):
	self.visible = true
	self.manage_input = manage_input
	for cont in controlls:
		if cont != current_controll:
			cont.active = false
	$Animation.play("FadeIn")

func close(manage_input=false):
	for cont in controlls:
		cont.active = true
	
	$Animation.play("FadeOut")
	yield($Animation, "animation_finished")
	self.manage_input = manage_input
	self.visible = false

func set_blur(amount, darknes):
	self.material.set_shader_param("amount", amount)
	self.material.set_shader_param("darknes", darknes)

func switch_controlls(id):
	if id < controlls.size():
		if current_controll != null:
			current_controll.active = false
		current_controll = controlls[id]
		current_controll.active = true
		return current_controll
	else:
		return null

func switch_scene(next_scene_template, return_scene):
	if not next_scene_template:
		return
	var new_scene = next_scene_template.instance()
	if return_scene:
		new_scene.return_scene_template = return_scene
	add_child(new_scene)

func confirm_selection(identities):
	versus(identities)
	

func request_restart():
	Transition.on()
	yield(Transition, "done_on")
	emit_signal("restart_requested")

func request_stop():
	Transition.on()
	yield(Transition, "done_on")
	emit_signal("stop_requested")

func menu():
	set_blur(2.5, 0.0)
	$Background.visible = true
	open()
	add_child(main_scene_template.instance())
	get_parent()

func pause():
	open()
	set_blur(2.5, 0.25)
	add_child(pause_scene_template.instance())

func tutorial():
	if ProjectSettings.get_setting("Witch-Ball/Tutorial"):
		set_blur(2.5, 0.25)
		$Background.visible = false
		var tutorial = tutorial_template.instance()
		add_child(tutorial)
		
		yield(tutorial, "tree_exited")
		emit_signal("intro_finished")
	close()

func versus(identities):
	self.manage_input = false
	set_blur(2.5, 0.0)
	
	var versus = versus_template.instance()
	
	versus.set_players(identities[0].selection, identities[1].selection)
	
	self.add_child(versus)
	yield(versus, "tree_exited")
	
	get_parent().start_match(identities)

func manage_input():
	var event
	
	if current_controll.state(Action.MENU_UP):
		event = "ui_up"
	if current_controll.state(Action.MENU_DOWN):
		event = "ui_down"
	if current_controll.state(Action.MENU_LEFT):
		event = "ui_left"
	if current_controll.state(Action.MENU_RIGHT):
		event = "ui_right"
	if current_controll.state(Action.MENU_SELECT):
		event = "ui_accept"
	if current_controll.state(Action.MENU_PAUSE):
		event = "ui_cancel"
	
	if event != null:
		var act = InputEventAction.new()
		act.action = event
		act.pressed = true
		Input.parse_input_event(act)
		act.pressed = false
		Input.parse_input_event(act)

