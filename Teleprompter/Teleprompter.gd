extends Node2D

signal new_chunk(id, time)
signal deborah_talking
signal deborah_stop_talking
	
var messages = {}	
	
func _ready():
	var file = File.new()
	file.open("res://messages.json", file.READ)
	var text = file.get_as_text()
	messages = parse_json(text)
	file.close()
	
	emit_signal("new_chunk", 'test', 4)
	
#func _process(delta):
#	if Input.is_action_just_pressed("ui_up"):
#		emit_signal("new_chunk", "test", 0)
#	if Input.is_action_just_pressed("ui_right"):
#		emit_signal("deborah_stop_talking")
#	if Input.is_action_just_pressed("ui_left"):
#		emit_signal("deborah_talking")
	
#	print(messages["messages"][0]["neutral"])