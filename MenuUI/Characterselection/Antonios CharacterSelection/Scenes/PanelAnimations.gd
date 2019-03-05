extends Node2D


func _on_Panel_focus_entered():
	$AnimationPlayer.play("AntoniosCharacterselection")
	$PlayerOneselecting.visible = true


func _on_Panel_focus_exited():
	$AnimationPlayer.play_backwards("AntoniosCharacterselection")
	$PlayerOneselecting.visible = false
	