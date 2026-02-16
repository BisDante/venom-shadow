extends Node2D

@onready var camera := $SubPixelCamera2D
@onready var endless_spawner := $EndlessEnemiesSpawner
@onready var placed_enemies := $PlacedEnemies
@onready var control_points := $ControlPoints
@onready var player := $Player

func _ready() -> void:
	Global.set_camera($SubPixelCamera2D)
	endless_spawner.set_player(player)
	
	for child in control_points.get_children():
		child.setup(player, self, camera)
		child.connect("set_camera_state", set_camera_state)
		child.connect("change_endless_spawner", change_endless_spawner)
	
	for child in placed_enemies.get_children():
		child.init()


func set_camera_state(state, position):
	camera.change_state(state, position)


func change_endless_spawner(data):
	endless_spawner.change_setup(data)
