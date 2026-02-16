extends StaticBody2D


func set_player(_player):
	pass


func set_scn_root(_scn_root):
	pass


func set_camera(_camera):
	pass


func reached():
	set_collision_layer_value(6, true)


func stage_event_end():
	print("InvisibleWalls")
	set_collision_layer_value(6, false)
