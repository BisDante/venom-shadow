extends Node

signal stage_ended

@export var event_triggers := false # se triggera com final de evento ou só de alcançar


func set_player(_player):
	pass


func set_scn_root(_scn_root):
	pass


func set_camera(_camera):
	pass


func reached():
	if not event_triggers:
		stage_ended.emit()


func on_stage_event_ended():
	if event_triggers:
		stage_ended.emit()
