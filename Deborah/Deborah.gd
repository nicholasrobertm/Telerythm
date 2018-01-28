extends AnimatedSprite

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() > 0:
		teleprompter[0].connect("deborah_talking", self, "_start_talking")
		teleprompter[0].connect("deborah_stop_talking", self, "_stop_talking")
	

func _calm_to_panic():
	animation.play("calm_to_panic")

func _panic_to_calm():
	animation.play("panic_to_calm")

func _start_talking():
	print("talking")
	#animaion.play("deborah_lips")
	
func _stop_talking():
	print("not talking")
	#animation.stop("deborah_lips")
