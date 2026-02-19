extends Node2D
class_name Enemy

var player : Player
var active = false

@onready var sprite = $Sprite2D
@onready var brain = $Brain

@export var health : int = 3
@export var score_value : int = 100
@export var curr_mode := Global.Mode.GREEN

signal enemy_dead(enemy)
signal killed_by_player


func _ready() -> void:
	brain.init(self)
	sprite.modulate = Color(0, 0.8, 0)


func set_player(_player):
	player = _player

func init():
	active = true

func receive_damage(damage):
	health -= damage
	if health <= 0:
		on_death()

func on_death():
	enemy_dead.emit(self)
	queue_free()

func set_mode(mode):
	curr_mode = mode
	print(curr_mode)
	if curr_mode == Global.Mode.GREEN:
		sprite.modulate = Global.ModeColors[0]
	elif curr_mode == Global.Mode.PURPLE:
		sprite.modulate = Global.ModeColors[1]
	else:
		sprite.modulate = Global.ModeColors[2]
		
func _physics_process(delta: float) -> void:
	if active:
		brain.update(delta)
