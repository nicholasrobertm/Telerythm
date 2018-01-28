extends GridContainer

signal success_failure(state)

var pattern = []
var success_pointer = 0

func _ready():
	columns = 4
	
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() == 0:
		return
		
	teleprompter = teleprompter[0]
	teleprompter.connect("new_chunk", self, 'new_combo')
	connect("success_failure", teleprompter, "success_failure")

func _input(event):
	if !pattern.empty() and event.is_action_pressed( pattern[ success_pointer ] ) and not event.is_echo():
		get_children()[ success_pointer ].modulate = Color(0,0,1)
		success_pointer += 1
		
		if success_pointer == pattern.size():
			success()
	
	elif not event.is_echo() and event.is_pressed() and event.as_text() in ['Up', 'Down', 'Left', 'Right']:
		failure()
		
func new_combo( id, time ):
	clear_arrows()
	
	for i in range( 0, int(time) ):
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
	emit_signal("success_failure", 'success')
	clear_arrows()

func failure():
	emit_signal("success_failure", 'failure')
	clear_arrows()
		
func clear_arrows():
	success_pointer = 0
	pattern = []
	for child in get_children():
		child.queue_free()