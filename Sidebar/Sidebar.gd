extends Node2D	

func _ready():
	var teleprompter = get_tree().get_nodes_in_group("Teleprompter")
	if teleprompter.size() != 0:
		teleprompter[0].connect("new_chunk", self, "_image_change")

func _image_change(id, status):
	#if id == 0:
	#	self.animation = "accumulation"
#		return
	#else:
		var message = get_tree().get_nodes_in_group("Teleprompter")[0].messages[id]
		if 'neutral' in message:
			self.animation = message['neutral_sidebar']
			
		elif 'good' in message:
			self.animation = message['good_sidebar']
		elif 'bad' in message:
			self.animation = message['bad_sidebar']