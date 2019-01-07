extends Sprite

func _ready():
	#$AnimationTreePlayer/AnimationPlayer.play("Walk_Bein")
	#$AnimationTreePlayer/AnimationPlayer.play("Walk_Arm")
	#$AnimationTreePlayer/AnimationPlayer.play("Idle_Bein")
	#$AnimationTreePlayer/AnimationPlayer.play("Idle_Arm")
	pass

func get_throw_point():
	return get_node("Charakter_Sprites/Ch1_T/Head&Arms/Ch1_A_r/Ch1_A_d_rr/throw_point").global_position

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
	
	$AnimationTreePlayer.oneshot_node_start("oneshot_dodge_down")

func play_dodge_up():
	$AnimationTreePlayer.oneshot_node_start("oneshot_dodge_up")

func play_hit():
	$AnimationTreePlayer.oneshot_node_start("oneshot_hit")
