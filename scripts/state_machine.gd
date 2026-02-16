extends Node

@export var current_state : Node
var actor
var states = []

func init(_actor):
	actor = _actor
	for child in get_children():
		child.init(actor)
		child.connect("change_state", change_state)
		states.append(child)

func update(delta):
	current_state.update(delta)
	
func change_state(new_state):
	if new_state == current_state:
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()
	
func check_hp():
	if actor.hp > 0:
		current_state.check_hp()
