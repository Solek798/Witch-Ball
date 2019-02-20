extends TextureRect
func AnimationHeart():
	$AnimationPlayer.play("HeartFadeOut")
	#$AnimationPlayer.play("HeartFadeOut1")
	#$AnimationPlayer.play("HeartFadeOut2")

func HeartIsEmpty():
	queue_free()
