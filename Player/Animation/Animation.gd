extends Sprite

func _ready():
	#$AnimationTreePlayer/AnimationPlayer.play("Walk_Bein")
	#$AnimationTreePlayer/AnimationPlayer.play("Walk_Arm")
	#$AnimationTreePlayer/AnimationPlayer.play("Idle_Bein")
	#$AnimationTreePlayer/AnimationPlayer.play("Idle_Arm")
	pass

func get_throw_point():
	return get_node("Charakter/Torso/Head_Arms/Arm_r/Hand_r/throw_point").global_position

func play_walk():
	$AnimationTreePlayer.blend2_node_set_amount("blend_walk", 1.0)

func stop_walk():
	$AnimationTreePlayer.blend2_node_set_amount("blend_walk", 0.0)

func play_throw(moving):
	if moving:
		$AnimationTreePlayer.oneshot_node_start("oneshot_walk_throw")
	else:
		$AnimationTreePlayer.oneshot_node_start("oneshot_idle_throw")

func play_dodge_down():
	pass

func play_dodge_up():
	pass

func play_hit():
	$AnimationTreePlayer.oneshot_node_start("oneshot_hit")

func play_WinnJump():
	$AnimationTreePlayer.oneshot_node_start("oneshot_WinnJump")

func play_indestructable():
	print("Los!")
	$AnimationTreePlayer/AnimationPlayer.play("Indestructable")

func stop_indestructabel():
	$AnimationTreePlayer/AnimationPlayer.stop()
	$Charakter.modulate.a = 1
	$Charakter.modulate.b = 1
	$Charakter.modulate.r = 1

	

