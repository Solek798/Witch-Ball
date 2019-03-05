extends Node2D


func _process(delta):
	if Input.is_joy_button_pressed(0, JOY_XBOX_A):
		$ConfirmPanel/HB1/Player1.is_filled = true
		validate()
	if Input.is_joy_button_pressed(1, JOY_XBOX_A):
		$ConfirmPanel/HB1/Player2.is_filled = true
		validate()
	if Input.is_key_pressed(KEY_ENTER):
		$ConfirmPanel/HB1/Player1.is_filled = true
		$ConfirmPanel/HB1/Player2.is_filled = true
		validate()

func validate():
	if $ConfirmPanel/HB1/Player1.is_filled and $ConfirmPanel/HB1/Player2.is_filled:
		$Animation.play("FadeOut")
		yield($Animation, "animation_finished")
		self.queue_free()