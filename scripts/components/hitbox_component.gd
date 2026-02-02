extends Area2D
class_name HitboxComponent

@onready var health_component : HealthComponent = get_parent().find_child("health_component")
@export var i_frames: float
var timer: float

func _process(delta: float) -> void:
	timer += delta

func damage(attack: Attack):
	if health_component && timer > i_frames:
		health_component.damage(attack)
		timer = 0
