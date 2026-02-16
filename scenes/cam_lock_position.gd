extends Marker2D
var camera : Camera2D

func set_player(_player):
	pass


func set_scn_root(_scn_root):
	pass


func set_camera(_camera):
	camera = _camera


func reached():
	camera.set_lock_pos(self.global_position)
	camera.change_state(camera.state_machine.get_child(1))

func stage_event_end():
	camera.change_state(camera.state_machine.get_child(0))
