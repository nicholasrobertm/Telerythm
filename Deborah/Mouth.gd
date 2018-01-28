extends AnimatedSprite

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _play(state):
	match state:
		true:
			animation.play("calm_talk")
		false:
			animation.play("panic_talk")
			
func _stop(state):
	match state:
		true:
			animation.play("calm_mouth")
		false:
			animation.play("panic_mouth")