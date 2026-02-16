extends Resource
class_name EnemyWave

@export var enemies : Array[PackedScene]
@export var position_indexes : Array[int]
@export var enemy_spawn_ids : Array[int]
@export var color_array : Array[Global.Mode]
@export var use_variable_spawn_time : bool
@export var next_enemy_time : int
@export var next_enemy_times : Array[int]
@export var next_wave_time : int
@export var is_next_wave_timed : bool
