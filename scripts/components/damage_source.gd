extends Area2D

@export var damage: int
@export var knockback: float
@export var destroy_on_damage: bool

var attack: Attack

func _ready() -> void:
	attack = Attack.new()
	attack.damage = damage
	attack.knockback = knockback	


func _on_area_entered(area: Area2D) -> void:
	var hitbox := area.get_parent().get_node_or_null("hitbox_component") as HitboxComponent
	if hitbox:
		attack.position = position
		hitbox.damage(attack)
		if destroy_on_damage:
			self.get_parent().queue_free()
