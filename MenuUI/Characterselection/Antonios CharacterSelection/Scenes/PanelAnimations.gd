extends Node2D



func _on_Panel_focus_entered():
	$AnimationPlayer.play("AntoniosCharacterselection")


func _on_Panel_focus_exited():
	$AnimationPlayer.play_backwards("AntoniosCharacterselection")

