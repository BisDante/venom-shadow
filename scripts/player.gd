extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const bullet = preload("res://scenes/bullet.tscn")
@onready var gun_pivot = $GunPivot
@onready var gun_tip = $GunPivot/GunTip
@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D

var curr_mode = Global.Mode.GREEN
var facing = 1 # 1 direita -1 esquerda
var hp = 3


func receive_damage():
	hp -= 1
	print("Ouch! HP: ", hp)


func _ready() -> void:
	state_machine.init(self)
	sprite.modulate = Color(0, 0.8, 0)

func change_mode():
	if curr_mode == Global.Mode.GREEN:
		curr_mode = Global.Mode.PURPLE
		sprite.modulate = Color(0.6, 0, 0.6)
		
	else:
		curr_mode = Global.Mode.GREEN
		sprite.modulate = Color(0, 0.8, 0)

func _physics_process(delta: float) -> void:
	state_machine.update(delta)


func graze():
	print("That was close!")


func _on_graze_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullets") and area.mode != curr_mode:
			graze()
