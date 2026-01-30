extends Area2D
class_name Bullet

const KILLTIME = 120
const SPEED = 1000
const DAMAGE = 2

@onready var sprite = $Sprite2D

var kill_time = KILLTIME
var velocity = Vector2.RIGHT
var mode := Global.Mode.YELLOW

func setup(is_players: bool, pos, angle: int, _mode):
	mode = _mode
	sprite.modulate = Global.ModeColors[_mode]
	global_position = pos
	set_angle(angle)
	
	if is_players:
		set_collision_layer_value(4, true)
		set_collision_mask_value(3, true)
		
	else:
		set_collision_layer_value(5, true)
		set_collision_mask_value(1, true)


func set_angle(angle) -> void:
	velocity = velocity.rotated(deg_to_rad(angle))
	global_rotation_degrees = angle


func _physics_process(delta: float) -> void:
	kill_time -= 1
	global_position += velocity * SPEED * delta
	
	if kill_time <= 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.curr_mode != mode:
		body.receive_damage(DAMAGE)
		queue_free()
	elif body.is_in_group("Enemies"):
		if body.curr_mode != mode:
			body.receive_damage(DAMAGE/2)
			queue_free()
	elif body.is_in_group("Level"):
		queue_free()
