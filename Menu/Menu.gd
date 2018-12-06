extends Node2D

signal match_instantiated(new_match)

# TEMP
export(PackedScene) var match_template


func _on_start_pressed():
	var new_match = match_template.instance()
	emit_signal("match_instantiated", new_match)

func _on_quit_pressed():
	get_tree().quit()
