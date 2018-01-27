extends Node2D	

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")[0]
	if teleprompter != null:
		teleprompter.connect("new_chunk", self, "_image_change")

func _image_change(id):
	self.animation = id
	self.play(id)
