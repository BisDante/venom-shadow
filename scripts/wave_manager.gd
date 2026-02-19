extends Node2D

var active : bool = false
var enemy_index = 0
var next_enemy_timer : int = 0
var wave_index : int = 0
var current_wave : EnemyWave
var wave_enemy_amt : int = 0
var wave_enemies_dead : int = 0
var wave_spawned_enemies : int = 0
var scn_root : Node2D
var living_enemies : Array[Enemy] = [] 

@onready var spawn_positions = get_children()
@export var enemy_waves : Array[EnemyWave]

signal stage_event_ended()


func reached():
	activate()


func _ready() -> void:
	current_wave = enemy_waves[wave_index]
	wave_enemy_amt = current_wave.enemy_spawn_ids.size()


func activate():
	active = true


func set_scn_root(_scn_root):
	scn_root = _scn_root


func set_player(_player):
	pass


func set_camera(_camera):
	pass

func spawn_next_wave():
	wave_index += 1
	next_enemy_timer = current_wave.next_wave_time
	current_wave = enemy_waves[wave_index]
	wave_enemy_amt = current_wave.enemy_spawn_ids.size()
	wave_spawned_enemies = 0
	wave_enemies_dead = 0
	enemy_index = 0

func spawn_next_enemy():
	var enemy_id = current_wave.enemy_spawn_ids[enemy_index]
	var enemy_position = spawn_positions[current_wave.position_indexes[enemy_index]].global_position
	var enemy_color = current_wave.color_array[enemy_index]
	var next_enemy = current_wave.enemies[enemy_id].instantiate()
	
	if enemy_index < current_wave.enemy_spawn_ids.size():
		enemy_index += 1
	
	scn_root.add_child(next_enemy)
	next_enemy.connect("enemy_dead", on_enemy_dead)
	living_enemies.append(next_enemy)
	next_enemy.global_position = enemy_position
	next_enemy.set_mode(enemy_color)
	next_enemy.init()
	
	if current_wave.use_variable_spawn_time:
		next_enemy_timer = current_wave.next_enemy_times[enemy_index]
	else:
		next_enemy_timer = current_wave.next_enemy_time
	
	wave_spawned_enemies += 1


func on_enemy_dead(enemy):
	living_enemies.erase(enemy)
	wave_enemies_dead += 1
	if wave_enemies_dead >= wave_enemy_amt:
		if wave_index + 1 < enemy_waves.size():
			spawn_next_wave()
		else:
			stage_event_ended.emit()


func stage_event_end():
	active = false


func on_player_dead():
	active = false
	enemy_index = 0
	next_enemy_timer = 0
	wave_index = 0
	current_wave = enemy_waves[wave_index]
	wave_enemy_amt = current_wave.enemy_spawn_ids.size()
	wave_enemies_dead = 0
	wave_spawned_enemies = 0
	
	for enemy in living_enemies:
		enemy.queue_free()
	living_enemies = []


func _physics_process(delta: float) -> void:
	if active:
		next_enemy_timer -= 1
		if next_enemy_timer <= 0 and wave_spawned_enemies < wave_enemy_amt:
			spawn_next_enemy()
