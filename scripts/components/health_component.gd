extends Node2D
class_name HealthComponent

@export var max_health := 1

var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

func damage(attack: Attack):
	health -= attack.damage
	if health <= 0:
		get_parent().queue_free()
