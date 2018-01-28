extends AnimatedSprite

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() > 0:
		teleprompter[0].connect("new_chunk", self, "_transition")
	
func _transition(id, status):
	if id != 0:
		if status:
			if $AnimationPlayer.assigned_animation != "panic_to_calm":
				$AnimationPlayer.play("panic_to_calm")
		else:
			if $AnimationPlayer.assigned_animation != "calm_to_panic":
				$AnimationPlayer.play("calm_to_panic")
	

func _eye_updated(mood,state):
	if state:
		if mood:
			$Eyes.animation.play("calm_blink")
		else:
			$Eyes.animation.play("panic_blink")
	else:
		if mood:
			$Eyes.animation.play("calm")
		else:
			$Eyes.animation.play("panic")

func _mouth_updated(mood, state):	
	if state:
		if mood:
			$Mouth.animation.play("calm_blink")
		else:
			$Mouth.animation.play("panic_blink")
	else:
		if mood:
			$Mouth.animation.play("calm")
		else:
			$Mouth.animation.play("panic")

func _calm_to_panic():
	$AnimationPlayer.play("calm_to_panic")

func _panic_to_calm():
	$AnimationPlayer.play("panic_to_calm")

func _start_talking():
	print("talking")
	#animaion.play("deborah_lips")
	
func _stop_talking():
	print("not talking")
	#animation.stop("deborah_lips")
