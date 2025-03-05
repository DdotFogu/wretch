extends Node3D

@export var force : Vector3

func Launch(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.velocity += force
	if body is RigidBody3D:
		body.linear_velocity.y += force
