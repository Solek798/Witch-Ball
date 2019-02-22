extends Sprite


func _ready():
	$Animation.play("RoundStart")


func _on_Animation_animation_finished(anim_name):
	self.queue_free()
