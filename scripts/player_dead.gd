extends State

func enter():
	actor.set_collision_layer_value(1, false)
	actor.player_dead.emit()

func update(delta):
	pass
