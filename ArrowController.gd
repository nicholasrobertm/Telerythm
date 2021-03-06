extends GridContainer

signal success(state)

var status = false

var pattern = []
var success_pointer = 0

func _ready():
	columns = 4
	
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() == 0:
		return
		
	teleprompter = teleprompter[0]
	teleprompter.connect("new_chunk", self, 'new_combo')
	connect("success", teleprompter, "success_failure")

func _input(event):
	if success_pointer < get_arrows().size() and event.is_action_pressed( pattern[ success_pointer ] ) and not event.is_echo():
		get_arrows()[ success_pointer ].get_node("AnimationPlayer").play("Success")
		success_pointer += 1
		
		if success_pointer == pattern.size():
			success()
	
	elif not event.is_echo() and event.is_pressed() and event.as_text() in ['Up', 'Down', 'Left', 'Right']:
		$AnimationPlayer.play("Failure")
		failure()
		
func new_combo( id, __ ):
	status = false
	clear_arrows()
	
	var pattern_size = ( get_parent().get_time() ) 
	pattern_size = int( clamp(pattern_size, 2, 12 ) )
	for i in range( 0, pattern_size ):
		var next_arrow = int( rand_range(0,4) ) 
		match next_arrow:
			0:
				next_arrow = 'Up'
			1:
				next_arrow = 'Down'
			2:
				next_arrow = 'Left'
			3:
				next_arrow = 'Right'

		pattern.push_back( next_arrow )
	
	for e in pattern:
		var arrow = load("res://Arrows/Up.tscn").instance()
		arrow.texture = load("res://Arrows/" + e + ".png")
		
		add_child( arrow )
		if get_parent().messages.size() <= get_parent().get_id() + 1:
			return
		if 'neutral' in get_parent().messages[get_parent().get_id() + 1]:
			arrow.get_node("AnimationPlayer").play("Intro")
		else:
			arrow.get_node("AnimationPlayer").play("Intro-Key")
		yield( arrow.get_node("AnimationPlayer"), "animation_finished")
		

func success():
	status = true
	emit_signal("success", true)


func failure():
	status = false
	for child in get_children():
		if child is AnimationPlayer:
			continue
		child.modulate = Color(1,1,1)
	emit_signal("success", false)
	
func get_arrows():
	var arrows = []
	for child in get_children():
		if not child is AnimationPlayer:
			arrows.push_back(child)
	return arrows
		
func clear_arrows():
	success_pointer = 0
	pattern = []
	for child in get_children():
		if child is AnimationPlayer:
			continue
		child.queue_free()
	rect_scale = Vector2(1,1)
	modulate = Color(1,1,1)
	rect_position = Vector2(0,480)