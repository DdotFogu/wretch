extends State
class_name chase

@onready var body = $"../.."

func enter():
	pass

func update(delta):
	if not body.is_on_floor():
		body.velocity.y -= body.GRAVITY * delta
	else:
		body.nav_agent.set_target_position(body.player.global_transform.origin)
		var next_nav_point = body.nav_agent.get_next_path_position()
		body.velocity = (next_nav_point - body.global_transform.origin).normalized() * body.SPEED
		body.rotation.y = lerp(body.rotation.y,atan2(-body.velocity.x,-body.velocity.z), .1)
		
		print(abs(body.velocity))
		if abs(body.velocity.x) > 0.1 or abs(body.velocity.z) > 0.1 : 
			body.anim_tree.get("parameters/playback").travel("Run")
		else:
			body.anim_tree.get("parameters/playback").travel("Idle")
		
	if target_in_range() == true:
		Transitioned.emit(self, "lunge")

func exit():
	pass

func target_in_range():
	return body.global_position.distance_to(body.player.global_position) < body.ATTACK_RANGE
