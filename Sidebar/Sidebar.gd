extends Node2D	

#func _ready():
#	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
#	if teleprompter.size() != 0:
#		teleprompter[0].connect("new_chunk", self, "_image_change")

#func _image_change(id, time):
#	self.animation = id
#	self.play(id)