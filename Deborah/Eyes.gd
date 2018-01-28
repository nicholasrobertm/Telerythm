extends AnimatedSprite


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _play(state):
	match state:
		true:
			animation.play("calm_blink")
		false:
			animation.play("panic_blink")
			
func _stop(state):
	match state:
		true:
			animation.play("calm_eyes")
		false:
			animation.play("panic_eyes")