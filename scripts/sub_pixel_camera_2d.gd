extends Camera2D

var actual_cam_pos: Vector2
var curr_lock_pos: Vector2
var viewport : SubViewportContainer
@export var speed = 10

@onready var state_machine = $StateMachine
@onready var player := $"../Player"

func _ready() -> void:
	if not viewport:
		viewport = Global.viewport
		
	state_machine.init(self)


func set_viewport(_viewport):
	viewport = _viewport


func set_lock_pos(lock_pos):
	curr_lock_pos = lock_pos

func change_state(state):
	state_machine.change_state(state)


func _process(delta: float) -> void:
	state_machine.update(delta)
