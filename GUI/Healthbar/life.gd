extends TextureRect

onready var is_filled = true setget set_is_filled


func set_is_filled(fill):
	if fill:
		$Animation.stop()
		$Animation.play("Reset")
	else:
		$Animation.play("HeartFadeOut")
		#$Animation.play("HeartFadeOut1")
		#$Animation.play("HeartFadeOut2")
	
	is_filled = fill
