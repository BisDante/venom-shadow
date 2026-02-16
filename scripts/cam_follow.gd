extends State


func update(delta):
	actor.actual_cam_pos = actor.actual_cam_pos.lerp(actor.player.global_position, delta * actor.speed)
	
	var subpixel_offset = actor.actual_cam_pos.round() - actor.actual_cam_pos
	actor.viewport.material.set_shader_parameter("cam_offset", subpixel_offset)
	actor.global_position = actor.actual_cam_pos.round()
