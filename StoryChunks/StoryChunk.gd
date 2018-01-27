extends Label

export var bodyText = ''
export var time = 0
export var button = ''

export var sound_clips = ['']

onready var id = int( name.replace('Chunk', '') )
var height

func _ready():
	text = bodyText
	
	height = get_line_count() * get_line_height()
	
	var scroll_tween = Tween.new()
	scroll_tween.interpolate_property(self, 'rect_position', rect_position, Vector2(0, -height + get_line_height() ), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	print(tween
	add_child(scroll_tween)
	scroll_tween.name = "ScrollTween"
	scroll_tween.start()
	
	scroll_tween.connect("tween_completed", self, "spawn_next")
	
func _process(delta):
	if name == 'Chunk0':
		print(rect_position)

func spawn_next(obj, k):
	var new_chunk = load("res://StoryChunks/Chunk" + str(id+1) + ".tscn")
	if new_chunk == null:
		return
	new_chunk = new_chunk.instance()
	
	new_chunk.rect_position = Vector2(0,get_line_height())# rect_global_position.y + height + get_line_height()*2
	get_parent().add_child( new_chunk )
	
	queue_free()
	
#	var current_position = rect_global_position
#	get_parent().remove_child(self)
#	new_chunk.add_child(self)
##	rect_global_position = current_position
##	rect_position = Vector2(0, -height)
#	rect_position.y -= 40
#	update()
#	modulate = Color(0,0,0,0)
	
#	rect_position = Vector2(0, height)
	