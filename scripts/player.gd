extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const bullet = preload("res://scenes/bullet.tscn")
@onready var gun_pivot = $GunPivot
@onready var gun_tip = $GunPivot/GunTip

enum State {IDLE, RUN, CROUCH, JUMP, FALL, DEATH, SPAWNING, WIN}
enum AimState {UP, DOWN, FORWARD}
enum Mode {GREEN, PURPLE}

var curr_state : State = State.IDLE
var curr_aim_state : AimState = AimState.FORWARD
var curr_mode = Mode.GREEN
var facing = 1 # 1 direita -1 esquerda
var hp = 3

func enter_state(state: State):
	curr_state = state
	match State:
		State.IDLE:
			pass


func quit_state():
	match curr_state:
		State.IDLE:
			pass


func change_state(state: State):
	quit_state()
	enter_state(state)


func receive_damage():
	hp -= 1
	print("Ouch! HP: ", hp)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if is_on_floor():
			facing = sign(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var shoot_angle = 0 + 90 * (facing - 1)
	
	if Input.is_action_just_pressed("shoot"):
		if Input.is_action_pressed("ui_up"):
			shoot_angle = -90
			
		gun_pivot.rotation_degrees = shoot_angle
		var new_bullet = bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(true, gun_tip.global_position, shoot_angle, Mode.GREEN)

	move_and_slide()
