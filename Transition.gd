extends CanvasLayer

signal done_on
signal done_off


func on():
	$Animation.play("FadeIn")

func off():
	$Animation.play("FadeOut")

func _on_Animation_animation_finished(anim_name):
	if anim_name == "FadeIn":
		emit_signal("done_on")
	else:
		emit_signal("done_off")
