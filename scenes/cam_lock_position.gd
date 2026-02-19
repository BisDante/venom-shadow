extends Marker2D

var camera : Camera2D
var player : Player

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


func on_player_dead():
	stage_event_end()
