extends State

func update(delta):
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity() * delta
	else:
		actor.velocity.y = 0
		
	actor.move_and_slide()
