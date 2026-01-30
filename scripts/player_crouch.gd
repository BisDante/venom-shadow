extends State

@export var run : Node
@export var fall : Node
@export var SPEED = 100.0

# Called when the node enters the scene tree for the first time.
func enter():
	actor.scale = Vector2(2, 0.5)
	

func exit():
	actor.scale = Vector2(1, 1)

func update(delta):
	if not Input.is_action_pressed("ui_down"):
		change_state.emit(run)
		
	if not actor.is_on_floor():
		change_state.emit(fall)

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

	actor.move_and_slide()
