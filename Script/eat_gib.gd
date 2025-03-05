extends RigidBody3D
@export var bbcode : String 
@export var text : String
@export var sizeY : int

func _ready() -> void:
	randomize()
	await get_tree().create_timer(randf_range(2, 3)).timeout
	$Blood.emitting = false

func play():
	get_node("/root/Main/Hud/InteractText").doText(bbcode, text, 0.9, 1.1, sizeY)
	visible = false
	$CollisionShape3D.disabled = true
	await get_tree().create_timer(1).timeout
