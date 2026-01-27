extends Node
class_name State

var actor
signal change_state(new_state)

func enter():
	pass


func exit():
	pass


func init(_actor):
	actor = _actor 


func update(delta):
	pass
