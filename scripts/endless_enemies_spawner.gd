extends Node2D

var active := false
var interval : int = 60
var timer : int = interval
var enemies_on_screen : int = 0
var spawn_positions
var spawn_pos_index : int = 0
var max_on_screen : int = 2
var enemy : PackedScene
var player : Player
var scn_root : Node2D


func _ready() -> void:
	spawn_positions = get_children()


func set_player(_player):
	player = _player


func set_scn_root(_scn_root):
	scn_root = _scn_root


func spawn_enemy():
	var new_enemy = enemy.instantiate()
	new_enemy.set_player(player)
	scn_root.add_child(new_enemy)
	new_enemy.global_position = spawn_positions[spawn_pos_index].global_position
	new_enemy.connect("dead", enemy_dead)
	new_enemy.init()
	
	enemies_on_screen += 1
	spawn_pos_index += 1
	spawn_pos_index = spawn_pos_index % spawn_positions.size()


func enemy_dead():
	enemies_on_screen -= 1


func change_setup(data):
	active = data.active
	enemy = data.enemy
	interval = data.interval
	max_on_screen = data.max_on_screen


func _physics_process(delta: float) -> void:
	global_position.x = player.global_position.x
	if active: 
		timer -= 1
		if timer <= 0 and not enemies_on_screen >= max_on_screen:
			timer = interval
			spawn_enemy()
		
