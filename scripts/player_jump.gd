extends State

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@export var run : Node
@export var fall : Node
@export var dead : Node

func check_hp():
	if actor.hp <= 0:
		change_state.emit(dead)


func enter():
	actor.velocity.y = JUMP_VELOCITY


func update(delta):
	actor.velocity += actor.get_gravity() * delta
	
	if actor.velocity.y >= 0:
		change_state.emit(fall)
	if actor.is_on_floor():
		change_state.emit(run)
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("mode"):
		actor.change_mode()

	if Input.is_action_just_pressed("shoot"):
		actor.shoot()

	actor.move_and_slide()
