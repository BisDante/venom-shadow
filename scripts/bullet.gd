extends Sprite2D
class_name Bullet

enum Mode {GREEN, PURPLE}

const KILLTIME = 120
const SPEED = 1000

@onready var collision_area = $Area2D

var kill_time = KILLTIME
var velocity = Vector2.RIGHT
var mode = Mode.GREEN

func setup(is_players: bool, pos, angle: int, _mode):
	mode = _mode
	global_position = pos
	set_angle(angle)
	
	if is_players:
		collision_area.set_collision_layer_value(4, true)
		collision_area.set_collision_mask_value(3, true)
		
	else:
		collision_area.set_collision_layer_value(5, true)
		collision_area.set_collision_mask_value(1, true)

func set_angle(angle) -> void:
	velocity = velocity.rotated(deg_to_rad(angle))
	global_rotation_degrees = angle


func _physics_process(delta: float) -> void:
	kill_time -= 1
	global_position += velocity * SPEED * delta
	
	if kill_time <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Actors"):
		body.receive_damage()
	queue_free()
