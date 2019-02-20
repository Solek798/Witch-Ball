extends Particles2D


func _ready():
	$End.wait_time = self.lifetime
	$End.start()

func _on_End_timeout():
	self.queue_free()
