extends Sprite

func _ready():
	
	yield( get_tree().create_timer(1.0), "timeout" )
	$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_type():
		get_tree().change_scene_to( preload("res://Newsroom.tscn") )
