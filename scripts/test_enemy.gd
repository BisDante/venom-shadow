extends Enemy

const bullet = preload("res://scenes/bullet.tscn")

@onready var gun_tip = $GunTip
@export var shoot_interval : int = 60
