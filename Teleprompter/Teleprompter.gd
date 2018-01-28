extends Node2D

signal new_chunk(id, time)
signal deborah_talking
signal deborah_stop_talking

signal success
signal failure
	
var messages = {}	
	
func _ready():
	var file = File.new()
	file.open("res://messages.json", file.READ)
	var text = file.get_as_text()
	messages = parse_json(text)
	file.close()
	
func success_failure( state ):
	emit_signal(state)
	
func new_chunk_in( id, time ):
	print('nci')
	emit_signal('new_chunk', id, time)
	
func _process(delta):
	# print(messages["messages"][0]["neutral"])
	