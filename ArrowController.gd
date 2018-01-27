extends Container

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() == 0:
		return
		
	teleprompter = teleprompter[0]
	teleprompter.connect("new_chunk", self, 'new_combo')

func new_combo():
	pass
