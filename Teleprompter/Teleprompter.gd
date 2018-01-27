extends Node2D

signal new_chunk(id)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("new_chunk", "test")
