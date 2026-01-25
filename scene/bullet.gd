extends Sprite2D

const KILLTIME = 120
const SPEED = 1000

var kill_time = KILLTIME
var velocity = Vector2.RIGHT

func set_angle(angle) -> void:
	velocity = velocity.rotated(deg_to_rad(angle))
	global_rotation_degrees = angle


func _physics_process(delta: float) -> void:
	kill_time -= 1
	global_position += velocity * SPEED * delta
	
	if kill_time <= 0:
		queue_free()
