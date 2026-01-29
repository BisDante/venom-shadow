extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var h_speed_variant: float = 1
var v_speed_variant: float = 1
var timer: float = 0

@export var h_speed: int = 60
@export var v_speed: int = 60
@export var h_duration: float = 2.0
@export var v_duration: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	h_speed_variant = ping_pong(delta, h_duration)	
	v_speed_variant = ping_pong(delta, v_duration)
	
	if(h_speed_variant < 0):
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
	
	position.x += delta * h_speed * h_speed_variant
	position.y += delta * v_speed * v_speed_variant	

func ping_pong(delta: float, duration: float) -> float:
	timer += delta
	return sin((timer / duration) * TAU)
