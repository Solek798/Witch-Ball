extends AudioStreamPlayer2D

export(Array, String, FILE, "*.wav") var files

onready var new_order = []


func play_random():
	if files != null: 
		self.stream = load(files[randi() % files.size()])
		self.play()

func play_defined_order(define_order = false):
	if define_order:
		if bool(round(randf())):
			new_order = [files.front(), files.back()]
		else:
			new_order = [files.back(), files.front()]
		
		return
	
	if self.stream == null:
		self.stream = load(new_order[0])
	else:
		self.stream = load(new_order[1])
	self.play()

func sort_random(a, b):
	return bool()
