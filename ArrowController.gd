extends GridContainer

signal pass_fail(state)

var pattern = []
var success_pointer = 0

func _ready():
	columns = 4
	
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() == 0:
		return
		
	teleprompter = teleprompter[0]
	teleprompter.connect("new_chunk", self, 'new_combo')
	connect("pass_fail", teleprompter, "pass_fail")

func _input(event):
	if event.is_action_pressed( pattern[ success_pointer ] ) and not event.is_echo():
		get_children()[ success_pointer ].modulate = Color(0,0,1)
		success_pointer += 1
		
		if success_pointer == pattern.size():
			success()
		
	elif event in ['Up', 'Down', 'Left', 'Right']:
		failure()
		
func new_combo( id, time ):
	for i in range( 0, int(time) * 2 ):
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

func success():
	emit_signal("pass_fail", 'pass')
	queue_free()

func failure():
	emit_signal("pass_fail", 'fail')
	queue_free()