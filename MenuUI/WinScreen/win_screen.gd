extends Control

var finished_match


func _ready():
	$Panel/HBoxContainer/rematch.grab_focus()
	self.set_winner(finished_match.winner.identity.id)
	self.set_image(finished_match.winner.body.win_image)
	finished_match.winner.body.play_voice(VoiceChannel.MATCH_WON)

func set_image(image):
	$Image.texture = image

func set_winner(id):
	$Panel/Text.text = "Player %d Wins!" % id

func _on_home_pressed():
	Transition.on()
	yield(Transition, "done_on")
	
	if get_parent().has_method("menu"):
		get_parent().menu()
	
	finished_match.queue_free()
	self.queue_free()

func _on_rematch_pressed():
	Transition.on()
	yield(Transition, "done_on")
	
	if get_parent().has_method("close"):
		get_parent().close()
	
	finished_match.reset()
	self.queue_free()

