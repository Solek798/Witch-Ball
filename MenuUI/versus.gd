extends Control


func _ready():
	$Animation.play("VS_Ani")
	pass

func VS_End():
	print("test")
	queue_free()
	
