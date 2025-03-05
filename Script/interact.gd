extends RayCast3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_collider() != null:
		get_node("/root/Main/Hud/Cursor").visible = true
		if Input.is_action_just_pressed("pi_interact"):
			print(get_collider())
			
			if get_collider().get_parent().has_method("play") == true:
				get_collider().get_parent().play()
			if get_collider().has_method("play") == true:
				get_collider().play()
	else:
		get_node("/root/Main/Hud/Cursor").visible = false
