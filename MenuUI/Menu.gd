extends Control


func switch_scene(next_scene_template):
	add_child(next_scene_template.insance())
