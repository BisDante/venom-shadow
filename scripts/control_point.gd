extends Marker2D

var is_reached = false
var player : Player


func setup(_player, _scn_root, _camera):
	player = _player
	for child in get_children():
		child.set_player(_player)
		child.set_scn_root(_scn_root)
		child.set_camera(_camera)
		
		if child.has_signal("stage_event_ended"):
			child.connect("stage_event_ended", on_stage_event_ended)



func on_stage_event_ended():
	for child in get_children():
		child.stage_event_end()


func _physics_process(delta: float) -> void:
	if not is_reached and player.global_position >= global_position:
		is_reached = true
		for child in get_children():
			child.reached()
