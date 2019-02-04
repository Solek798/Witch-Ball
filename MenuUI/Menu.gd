extends Control

signal requested_match_restart
signal requested_match_canceled
signal requested_match_start(selection)


func _ready():
	pass

func switch_scene(next_scene_template):
	for child in get_children():
		child.queue_free()
	add_child(next_scene_template.instance())

func request_match_start(selection):
	emit_signal("requested_match_start", selection)

func request_match_restart():
	emit_signal("requested_match_restart")

func request_match_cancel():
	emit_signal("requested_match_cancel")