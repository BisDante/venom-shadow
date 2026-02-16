extends State

var timer := 0
@export var interval : int = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	timer -= 1
	# Add the gravity.
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity() * delta

	if timer <= 0:
		var new_bullet = actor.bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(false, actor.gun_tip.global_position, 180, actor.curr_mode)
		timer = actor.shoot_interval

	actor.move_and_slide()
