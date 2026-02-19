extends Marker2D

var id

signal checkpoint_reached(checkpoint)

func set_player(_player):
	pass


func set_scn_root(_scn_root):
	pass


func set_camera(_camera):
	pass


func stage_event_end():
	pass


func reached():
	checkpoint_reached.emit(self)


func on_player_dead():
	pass
