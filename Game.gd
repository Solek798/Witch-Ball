extends Node


func _ready():
	randomize()
	$Music.play()
	
	$Menu.selection = $Characterselection
	$Menu.selection1 = $OptionScene
	$Menu.Credits = $Credits
	
	$Characterselection.connect("match_instantiated", self, "_on_match_instantiated")
	
	$OptionScene.selectionMenu = $Menu
	
	$Credits.selectionMenu = $Menu
	
	
	
	

func _on_match_instantiated(new_match):
	new_match.connect("match_finished", self, "_on_match_finished")
	add_child(new_match)
	$Characterselection.visible = false
	$Music.stop()

func _on_match_finished(finished_match):
	finished_match.queue_free()
	$Menu.visible = true
	$Music.play()

func _on_Music_finished():
	$Music.play()
