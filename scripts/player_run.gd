extends State

@export var jump : Node
@export var fall: Node

signal change_state(new_state)

func update(delta):
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity() * delta
		# change_state.emit(fall)

	if Input.is_action_just_pressed("ui_accept") and actor.is_on_floor():
		change_state.emit(jump)

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if actor.is_on_floor():
			actor.facing = sign(direction)
		actor.velocity.x = direction * actor.SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, actor.SPEED)

	var shoot_angle = 0 + 90 * (actor.facing - 1)
	
	if Input.is_action_just_pressed("shoot"):
		if Input.is_action_pressed("ui_up"):
			shoot_angle = -90
			
		actor.gun_pivot.rotation_degrees = shoot_angle
		var new_bullet = actor.bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(true, actor.gun_tip.global_position, shoot_angle, Global.Mode.GREEN)

	actor.move_and_slide()
