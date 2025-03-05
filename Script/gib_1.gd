extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(randf_range(3, 6)).timeout
	queue_free()
