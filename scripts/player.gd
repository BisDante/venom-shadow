extends CharacterBody2D

const bullet = preload("res://scenes/bullet.tscn")
@onready var gun_pivot = $GunPivot
@onready var gun_tip = $GunPivot/GunTip
@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D
@onready var coll_shape = $CollisionShape2D
@onready var graze_shape = $GrazeRange/CollisionShape2D

var curr_mode = Global.Mode.GREEN
var facing = 1 # 1 direita -1 esquerda
var hp = 6


func receive_damage(damage):
	hp -= damage
	print("Ouch! HP: ", hp)


func get_shoot_angle():
	var shoot_angle = 0 + 90 * (facing - 1)
	if not is_on_floor():
		var updown = Input.get_axis("ui_up", "ui_down")
		if updown:
			shoot_angle = 90 * updown
		
	elif Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		shoot_angle = -90

	return shoot_angle


func shoot():
	var shoot_angle = get_shoot_angle()
	gun_pivot.rotation_degrees = shoot_angle
	var new_bullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	new_bullet.setup(true, gun_tip.global_position, shoot_angle, curr_mode)


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
