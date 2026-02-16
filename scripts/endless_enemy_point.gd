extends Marker2D

var player
var is_reached := false
@export var active := true
@export var enemy : PackedScene
@export var interval : int = 30
@export var max_on_screen : int = 2

signal reached(data)


func set_player(_player):
	player = _player


func _physics_process(delta: float) -> void:
	if player.global_position.x > global_position.x and not is_reached:
		is_reached = true
		reached.emit(self)
