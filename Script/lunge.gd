extends State
class_name lunge

@onready var body = $"../.."
@onready var attack_area: ShapeCast3D = $"../../attack_area"

var did_launch : bool = false

func enter():
	body.anim_tree.get("parameters/playback").travel("lunge")
	var launch_vector = body.position.direction_to(body.player.position).normalized()
	
	body.velocity.x += launch_vector.x 
	body.velocity.z += launch_vector.z 
	body.velocity.y += 5
	
	attack_area.enabled = true
	
	await get_tree().create_timer(0.25).timeout
	did_launch = true

func exit():
	pass

func update(delta):
	var colliding_body = attack_area.get_collider(0)
	if colliding_body != null && attack_area.enabled == true:
		attack_area.enabled = false
		colliding_body.get_parent().get_node("health_component").hurt(25)
	
	if not body.is_on_floor():
		body.velocity.y -= body.GRAVITY * delta
	elif body.is_on_floor():
		if did_launch == true:
			body.velocity = Vector3.ZERO
			attack_area.enabled = false
			body.anim_tree.get("parameters/playback").travel("struggle")
	
	body.move_and_slide()
