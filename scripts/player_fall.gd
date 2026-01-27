extends State

@export var run : Node
@export var glide : Node

func update(delta):
	actor.velocity += actor.get_gravity() * delta

	if actor.is_on_floor():
		change_state.emit(run)
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		actor.velocity.x = direction * actor.SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, actor.SPEED)

	if Input.is_action_just_pressed("ui_accept"):
		change_state.emit(glide)

	if Input.is_action_just_pressed("mode"):
		actor.change_mode()

	var shoot_angle = 0 + 90 * (actor.facing - 1)
	if Input.is_action_just_pressed("shoot"):
		if Input.is_action_pressed("ui_up"):
			shoot_angle = -90

		actor.gun_pivot.rotation_degrees = shoot_angle
		var new_bullet = actor.bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(true, actor.gun_tip.global_position, shoot_angle, actor.curr_mode)

	actor.move_and_slide()
