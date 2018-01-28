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
			$Eyes.play("calm_blink")
		else:
			$Eyes.play("panic_blink")
	else:
		if mood:
			$Eyes.play("calm")
		else:
			$Eyes.play("panic")

func _mouth_updated(mood, state):	
	if state:
		if mood:
			$Mouth.play("calm_blink")
		else:
			$Mouth.play("panic_blink")
	else:
		if mood:
			$Mouth.play("calm")
		else:
			$Mouth.play("panic")

func _calm_to_panic():
	$AnimationPlayer.play("calm_to_panic")

func _panic_to_calm():
	$AnimationPlayer.play("panic_to_calm")
