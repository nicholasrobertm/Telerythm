extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_UP):
		print("test")
	elif Input.is_key_pressed(KEY_DOWN):
		print("test")
	elif Input.is_key_pressed(KEY_LEFT):
		print("test")
	elif Input.is_key_pressed(KEY_RIGHT):
		print("test")
	else:
		print("test")
	
