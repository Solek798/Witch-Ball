extends Container

export(String, FILE, "*.tscn") var path_to_own_template



func _on_Tutorial_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("ResetPosition") #TutorialButton
	$AnimatonPlayer/TutorialCharacterAnimation.play("ResetAnimation")

func _on_Walk_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("WalkPosition")
	$AnimatonPlayer/TutorialCharacterAnimation.play("WalkAnimation")

func _on_Throw_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("ThrowPositionBall")
	$AnimatonPlayer/TutorialCharacterAnimation.play("ThrowAnimation")

func _on_Aim_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("AimPosition") #TutorialButton
	$AnimatonPlayer/TutorialCharacterAnimation.play("ResetAnimation")
	
	pass # replace with function body




func _on_ThrowSpezial_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("ThrowSpezPositionBall")
	$AnimatonPlayer/TutorialCharacterAnimation.play("ThrowAnimation")
	pass # replace with function body


func _on_Doge_focus_entered():
	$AnimatonPlayer/TutorialPositionAnimation.play("DogePosition")
	$AnimatonPlayer/TutorialCharacterAnimation.play("WalkAnimation")
	pass # replace with function body
