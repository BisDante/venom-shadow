extends Enemy

@export var speed = 300.0

func init():
	self.velocity = Vector2.LEFT * speed
	if global_position.x < player.global_position.x:
		self.velocity *= -1
		sprite.flip_h = true
	active = true


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	on_death()
