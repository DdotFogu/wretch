extends StaticBody3D

@export var obj : PackedScene
@export var spawn_position : Vector3

func play():
	var object = obj.instantiate()
	object.position = spawn_position
	$"..".add_child(object)
