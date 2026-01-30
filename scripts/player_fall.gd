extends State

@export var SPEED = 200.0
@export var run : Node
@export var glide : Node

func update(delta):
	actor.velocity += actor.get_gravity() * delta

	if actor.is_on_floor():
		change_state.emit(run)
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept"):
		change_state.emit(glide)

	if Input.is_action_just_pressed("mode"):
		actor.change_mode()

	if Input.is_action_just_pressed("shoot"):
		actor.shoot()

	actor.move_and_slide()
