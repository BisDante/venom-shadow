extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const INTERVAL = 60
const bullet = preload("res://scenes/bullet.tscn")

@onready var gun_tip = $GunTip
@onready var sprite = $Sprite2D

var timer = INTERVAL
var curr_mode := Global.Mode.GREEN


func _ready() -> void:
	sprite.modulate = Color(0, 0.8, 0)


func receive_damage():
	print("ouch!")
	

func _physics_process(delta: float) -> void:
	timer -= 1
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if timer <= 0:
		var new_bullet = bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(false, gun_tip.global_position, 180, curr_mode)
		timer = INTERVAL

	move_and_slide()
