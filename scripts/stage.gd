extends Node2D

@onready var stage_beginning := $StageBeginning
@onready var camera := $SubPixelCamera2D
@onready var endless_spawner := $EndlessEnemiesSpawner
@onready var placed_enemies := $PlacedEnemies
@onready var control_points := $ControlPoints
@onready var player := $Player
@onready var curr_checkpoint = stage_beginning

var curr_control_point

func _ready() -> void:
	Global.set_camera($SubPixelCamera2D)
	endless_spawner.set_player(player)
	player.connect("player_dead", on_player_dead)
	
	for child in control_points.get_children():
		child.setup(player, self, camera)
		child.connect("control_point_reached", on_control_point_reached)
		
		if child.has_node("Checkpoint"):
			var checkpoint = child.get_node("Checkpoint")
			checkpoint.connect("checkpoint_reached", on_checkpoint_reached)
	
	for child in placed_enemies.get_children():
		child.init()


func on_control_point_reached(control_point):
	curr_control_point = control_point


func on_checkpoint_reached(_checkpoint):
	curr_checkpoint = _checkpoint


func on_player_dead():
	player.revive()
	
	if player.lives > 0:
		player.global_position = curr_checkpoint.global_position
	else:
		curr_checkpoint = stage_beginning
		player.global_position = curr_checkpoint.global_position
		player.lives = player.max_lives
