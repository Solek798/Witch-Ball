extends Control

 
export(Resource) var Scarlett
export(Resource) var Jasmine
export(Resource) var Lilith
export(Resource) var Penny

# Idee 
#bsp.: Wenn SPlayer 1 Scarlett Spiel dann wird unter ../player/P1 ein  child (var Scarlett)erzeugt

func _ready():
	$Animation.play("VS_Ani")
	pass


func _on_Animation_animation_finished(anim_name):
	self.queue_free()
