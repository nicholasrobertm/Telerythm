extends Node2D

signal new_chunk(id, status)
signal success(status)
	
var messages = []
	
func _ready():
	var file = File.new()
	file.open("res://messages.json", file.READ)
	var text = file.get_as_text()
	messages = parse_json(text)['messages']
	file.close()
	
func success_failure( state ):
	emit_signal('success', state)
	
func new_chunk_in(id):
	emit_signal('new_chunk', id, get_status())

# state reading 

func get_status():
	return $ArrowController.status
	
func get_id():
	if $Viewport.get_children().size() > 0:
		return $Viewport.get_children()[0].id
	else:
		return 0
	
func get_time():
	var message = messages[ get_id() ]
	
	if 'neutral' in message:
		return message['neutral_audio_length']
	elif get_status() == true:
		return message['good_audio_length']
	elif get_status() == false:
		return message['bad_audio_length']
	
	
	