extends TextureButton

export(PackedScene) var next_scene
export(PackedScene) var particle_template

var active_particle

func _on_Button_focus_entered():
	var particle = particle_template.instance()
	# TEMP
	active_particle = particle
	
	add_child(particle)

func _on_Button_focus_exited():
	var children = get_children()
	children.remove(children.find(active_particle))
