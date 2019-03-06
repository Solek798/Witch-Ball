extends Control

export(Dictionary) var sets = {4: 5}
export(PackedScene) var test
# Idee 
#bsp.: Wenn SPlayer 1 Scarlett Spiel dann wird unter ../player/P1 ein  child (var Scarlett)erzeugt


func _ready():
	$Animation.play("VS_Ani")

func set_players(player1, player2):
	
	$player/P1.add_child(player1.instance().versus_template.instance())
	$player/P2.add_child(player2.instance().versus_template.instance())

func _on_Animation_animation_finished(anim_name):
	self.queue_free()
