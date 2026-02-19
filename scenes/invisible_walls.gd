extends StaticBody2D

var player : Player

func set_player(_player):
	pass


func set_scn_root(_scn_root):
	pass


func set_camera(_camera):
	pass


func reached():
	set_collision_layer_value(6, true)


func stage_event_end():
	set_collision_layer_value(6, false)


func on_player_dead():
	stage_event_end()
