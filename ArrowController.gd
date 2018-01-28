extends GridContainer

var pattern = []

func _ready():
	columns = 4
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() == 0:
		return
		
	teleprompter = teleprompter[0]
	teleprompter.connect("new_chunk", self, 'new_combo')

func new_combo( id, time ):
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
		print(next_arrow)
		pattern.push_back( next_arrow )
	
	for e in pattern:
		var arrow = load("res://Arrows/Up.tscn").instance()
		arrow.texture = load("res://Arrows/" + e + ".png")
		
		add_child( arrow )
