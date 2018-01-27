extends Node2D

signal new_chunk(id)
signal deborah_talking
signal deborah_stop_talking
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("new_chunk", "test")
	if Input.is_action_just_pressed("ui_right"):
		emit_signal("deborah_stop_talking")
	if Input.is_action_just_pressed("ui_left"):
		emit_signal("deborah_talking")