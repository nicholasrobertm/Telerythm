extends AnimatedSprite

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")[0]
	if teleprompter != null:
		teleprompter.connect("deborah_talking", self, "_start_talking")
		teleprompter.connect("deborah_stop_talking", self, "_stop_talking")

func _start_talking():
	print("talking")
	#animaion.play("deborah_lips")
	
func _stop_talking():
	print("not talking")
	#animation.stop("deborah_lips")
