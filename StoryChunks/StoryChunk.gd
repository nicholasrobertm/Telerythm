extends Label

export var bodyText = ''
export var time = 0
export var button = ''

export var sound_clips = ['']

onready var id = int( name.replace('Chunk', '') )

func _ready():
	text = bodyText
	
	var height = get_line_count() * get_line_height()
	
	var scroll_tween = Tween.new()
	scroll_tween.interpolate_property(self, 'rect_position', rect_position, Vector2(0, -height + 30 ), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	print(tween
	add_child(scroll_tween)
	scroll_tween.name = "ScrollTween"
	scroll_tween.start()
	
	scroll_tween.connect("tween_completed", self, "spawn_next")
	
func _process(delta):
	print(rect_position)

func spawn_next(obj, k):
	var new_chunk = load("res://StoryChunks/Chunk" + str(id+1) + ".tscn")
	if new_chunk == null:
		get_tree().quit()
		return
	new_chunk = new_chunk.instance()
	
	get_parent().add_child( new_chunk )
	
#	new_chunk.rect_position = Vector2(0,100)# rect_global_position.y + height + get_line_height()*2
	
#	var current_position = rect_global_position
#	get_parent().remove_child(self)
#	new_chunk.add_child(self)
#	rect_global_position = current_position
	
#	rect_position = Vector2(0, height)
	