extends Control

func _ready():
	$Animation.play("Beginn_Ani")
	pass


func _on_Animation_animation_finished(anim_name):
	self.queue_free()
