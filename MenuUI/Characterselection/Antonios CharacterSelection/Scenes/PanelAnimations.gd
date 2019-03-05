extends Node2D



func _on_Panel_focus_entered():
	$AnimationPlayer.play("AntoniosCharacterselection")
	$Selections.visible = true
	


func _on_Panel_focus_exited():
	$AnimationPlayer.play_backwards("AntoniosCharacterselection")
	$Selections.visible = false

