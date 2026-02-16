extends Node

enum StageEvent {SET_CAMERA_MODE}
enum Mode {GREEN, PURPLE, YELLOW}
const ModeColors = [Color(0, 0.8, 0), Color(0.6, 0, 0.6), Color(1, 1, 0)]


var viewport : SubViewportContainer
var camera : Camera2D


func set_viewport(_viewport):
	viewport = _viewport
	camera.set_viewport(_viewport)


func set_camera(_camera):
	camera =_camera
