extends StaticBody3D

@onready var interactCast = get_node("/root/Main/Player/Interpolated Camera/Arm/Arm Anchor/Interact")
var opened : bool = false

@export var closeRot : int = -180
@export var openRot : int = -65

func play():
	if opened == true:
		opened = false
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "rotation_degrees:y", closeRot, 1)
	elif opened == false:
		opened = true
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "rotation_degrees:y", openRot, 1)
