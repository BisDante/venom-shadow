extends Node

signal dead
signal killed_by_player

@export var value : int = 3


func check():
	if value <= 0:
		dead.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func die():
	value = 0
	check()
