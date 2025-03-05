extends Area3D

@export var telePos : Vector3

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.position = telePos
