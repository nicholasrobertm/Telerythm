extends Label

export var bodyText = ''
export var time = 0
export var goodClip = ''
export var badClip = ''

onready var id = int( name.replace('Chunk', '') )
var next_chunk
var height

var show_next = false

signal new_chunk(id, time)

func _ready():
	text = bodyText
	
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() != 0:
		teleprompter = teleprompter[0]
		teleprompter.connect("success", self, 'success')
		connect('new_chunk', teleprompter, 'new_chunk_in')
		
	emit_signal('new_chunk', 'id', time)
	
	height = get_line_count() * get_line_height()
	next_chunk = load("res://StoryChunks/Chunk" + str(id+1) + ".tscn")
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
	
	next_chunk.rect_position = Vector2(rect_position.x,0)# rect_global_position.y + height + get_line_height()*2
	get_parent().add_child( next_chunk )
	
	if show_next == false:
		next_chunk.self_modulate = Color(0,0,0,0)
	
	queue_free()
	
func success():
	show_next = true
	
#	var current_position = rect_global_position
#	get_parent().remove_child(self)
#	next_chunk.add_child(self)
##	rect_global_position = current_position
##	rect_position = Vector2(0, -height)
#	rect_position.y -= 40
#	update()
#	modulate = Color(0,0,0,0)
	
#	rect_position = Vector2(0, height)
	