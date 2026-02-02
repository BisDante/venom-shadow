extends State

@export var SPEED = 200.0
@export var FALL_SPEED = 20
@export var run : Node
@export var fall : Node

func update(delta):
	actor.velocity.y = FALL_SPEED
	
	if actor.is_on_floor():
		change_state.emit(run)
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept"):
		change_state.emit(fall)

	if Input.is_action_just_pressed("shoot"):
		actor.shoot()

	actor.move_and_slide()
