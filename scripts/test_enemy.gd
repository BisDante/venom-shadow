extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const INTERVAL = 60
const bullet = preload("res://scenes/bullet.tscn")

@onready var gun_tip = $GunTip

var timer = INTERVAL


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
		new_bullet.setup(false, gun_tip.global_position, 180, 0)
		timer = INTERVAL

	move_and_slide()
