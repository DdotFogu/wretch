extends RigidBody3D

@export var speed := 10.0
@export var height := 1.0

func _ready() -> void:
	var camera = get_node("/root/Main/Player/Interpolated Camera")
	var direction = -camera.global_transform.basis.z.normalized()
	apply_central_impulse(direction * speed + (get_node("/root/Main/Player/Body").velocity * 0.7))
	apply_central_impulse(Vector3(0,1,0) * height)
	
	await get_tree().create_timer(0.5).timeout
	$trigger_area/CollisionShape3D.disabled = false

func _on_trigger_area_body_entered(body: Node3D) -> void:
	var bodies = $explosion_radius.get_overlapping_bodies()
	for node in bodies:
		var launch_vector = position.direction_to(body.position).normalized() * 15
		var body_velo : Vector3
		await get_tree().create_timer(0.2).timeout
		if node is CharacterBody3D:
			node.velocity.x += launch_vector.x 
			node.velocity.z += launch_vector.z 
			node.velocity.y += 5
		if node is RigidBody3D:
			body_velo = node.linear_velocity
			node.apply_impulse(body_velo * 10)
		
		print(launch_vector)
	queue_free()
