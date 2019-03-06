extends AudioStreamPlayer2D

export(Array, String, FILE, "*.wav") var files


func play_random():
	if files != null: 
		self.stream = load(files[randi() % files.size()])
		self.play()

func play_defined_order(define_order = false):
	if define_order:
		files.sort_custom(self, "sort_random")
		return
	
	self.stream = load(files[files.find(self.stream) + 1])
	self.play()

func sort_random(a, b):
	return round(randf())
