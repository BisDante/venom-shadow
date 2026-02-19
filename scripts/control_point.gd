extends Marker2D

var is_reached := false
var active := false
var player : Player

signal control_point_reached(control_point)

func setup(_player, _scn_root, _camera):
	player = _player
	player.connect("player_dead", on_player_dead)
	
	for child in get_children():
		child.set_player(_player)
		child.set_scn_root(_scn_root)
		child.set_camera(_camera)
		
		if child.has_signal("stage_event_ended"):
			child.connect("stage_event_ended", on_stage_event_ended)


func on_stage_event_ended():
	for child in get_children():
		child.stage_event_end()
	active = false


func on_player_dead():
	if active:
		for child in get_children():
			child.on_player_dead()
		is_reached = false


func _physics_process(delta: float) -> void:
	if not is_reached and player.global_position >= global_position:
		is_reached = true
		active = true
		for child in get_children():
			child.reached()
		control_point_reached.emit(self)
