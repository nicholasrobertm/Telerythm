extends Sprite

func _input(event):
	if event.is_action_type():
		get_tree().change_scene_to( preload("res://Newsroom.tscn") )
