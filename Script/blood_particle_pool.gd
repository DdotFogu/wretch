class_name BloodParticlePool

const MAX_BLOOD_DECALS = 1000
static var decal_pool := []

static func spawn_blood_decal(global_pos : Vector3, normal : Vector3, parent : Node3D, blood_basis : Basis, texture_override = null):
	var decal_instance : Node3D
	if len(decal_pool) >= MAX_BLOOD_DECALS and is_instance_valid(decal_pool[0]):
		decal_instance = decal_pool.pop_front()
		decal_pool.push_back(decal_instance)
		decal_instance.reparent(parent)
	else:
		decal_instance = preload("res://scene/particles/blood_decal.tscn").instantiate()
		parent.add_child(decal_instance)
		decal_pool.push_back(decal_instance)
	
	# Clear invalid if necessary. Parent may have gotten .queue_free()'d
	if not is_instance_valid(decal_pool[0]):
		decal_pool.pop_front()
	
	# Rotate decal towards player for things like horizontal knife slash decals
	decal_instance.global_transform = Transform3D(blood_basis, global_pos) * Transform3D(Basis().rotated(Vector3(1,0,0), deg_to_rad(90)), Vector3())
	# Align to surface
	decal_instance.global_basis = Basis(Quaternion(decal_instance.global_basis.y, normal)) * decal_instance.global_basis
	
	if texture_override is Texture2D:
		decal_instance.texture_albedo = texture_override

static func spawn_blood_particle(global_pos : Vector3, parent : Node3D):
	var particle_instance : Node3D
	particle_instance = preload("res://scene/particles/blood_particle.tscn").instantiate()
	particle_instance.emitting = true
	particle_instance.global_position = global_pos
	parent.add_child(particle_instance)
	
