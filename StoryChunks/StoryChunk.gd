extends Label

#export var bodyText = ''
export var time = 0

var id
var next_chunk
var height

signal new_chunk(id)

func init(i):
	id = i
	
	var message = $"../..".messages[id]
	if 'neutral' in message:
		text = message['neutral']
		time = message['neutral_audio_length']
		var stream = load("res://Voice/" + message['neutral_audio_file'])
		$AudioStreamPlayer.stream = stream
		
	elif 'good' in message:
		text = message['good']
		
		if $"../..".get_status() == true:
			time = message['good_audio_length']
			$AudioStreamPlayer.stream = load("res://Voice/" + message['good_audio_file'])
		else:
			time = message['bad_audio_length']
			$AudioStreamPlayer.stream = load("res://Voice/" + message['bad_audio_file'])
			
	$AudioStreamPlayer.play()
	
	

func _ready():
	yield( get_tree().create_timer(0.1), "timeout")
	if id == null:
		init(0)
	
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() != 0:
		teleprompter = teleprompter[0]
		teleprompter.connect("success", self, 'success')
		connect('new_chunk', teleprompter, 'new_chunk_in')
	
	emit_signal('new_chunk', id)
	
	height = get_line_count() * get_line_height()
	next_chunk = load("res://StoryChunks/BaseChunk.tscn")
	if next_chunk != null:
		var caret = load("res://StoryChunks/Caret.tscn").instance()
		caret.rect_position = Vector2(0, height)
		add_child( caret )
	
	var scroll_tween = Tween.new()
	scroll_tween.interpolate_property(self, 'rect_position', rect_position, Vector2(rect_position.x, -height ), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	add_child(scroll_tween)
	scroll_tween.name = "ScrollTween"
	scroll_tween.start()
	
	scroll_tween.connect("tween_completed", self, "spawn_next")

func spawn_next(obj, k):
	if next_chunk == null:
		return
	next_chunk = next_chunk.instance()
	
	next_chunk.rect_position = Vector2(rect_position.x,0)
	next_chunk.id = id+1
	get_parent().add_child( next_chunk )
	next_chunk.init( id+1 )
	
	if not ('neutral' in $"../..".messages[next_chunk.id]) and $"../..".get_status() == false:
		next_chunk.self_modulate = Color(0,0,0,0)
	
	queue_free()
	