extends Node

@onready var current_state = $PlayerRun

func init(actor):
	for child in get_children():
		child.init(actor)
		child.connect("change_state", change_state)

func update(delta):
	current_state.update(delta)
	
func change_state(new_state):
	if new_state == current_state:
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()
