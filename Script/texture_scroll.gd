@tool

extends MeshInstance3D

@export var x_speed := 0.3
@export var y_speed := 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	material_override.uv1_offset.x += x_speed * delta
	material_override.uv1_offset.y += y_speed * delta
