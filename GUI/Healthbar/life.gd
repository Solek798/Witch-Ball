extends TextureRect
func AnimationHeart():
	$AnimationPlayer.play("HeartFadeOut")

func HeartIsEmpty():
	queue_free()
