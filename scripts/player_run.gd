extends State

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@export var jump: Node
@export var fall: Node
@export var crouch: Node
@export var dead: Node

func check_hp():
	if actor.hp <= 0:
		change_state.emit(dead)

func update(delta):
	if not actor.is_on_floor():
		change_state.emit(fall)

	if Input.is_action_just_pressed("ui_accept"):
		change_state.emit(jump)

	if Input.is_action_pressed("ui_down"):
		change_state.emit(crouch)

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if actor.is_on_floor():
			actor.facing = sign(direction)
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("mode"):
		actor.change_mode()

	if Input.is_action_just_pressed("shoot"):
		actor.shoot()
		
	if Input.is_action_just_pressed("special"):
		actor.shoot_special()

	actor.move_and_slide()
