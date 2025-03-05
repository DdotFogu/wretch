extends Node3D

@export var item : Array[Dictionary]
@onready var inv_component = get_node("/root/Main/Player/inventory_component")
@onready var items_hud : Control = get_node("/root/Main/Hud/Ui/items")
@onready var ground_check: RayCast3D = $"Ground Check"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while ground_check.get_collider() == null:
		await get_tree().create_timer(0.01).timeout
		position.y -= 0.05

func play():
	inv_component.add_item(item[0])
	items_hud.apply_shake(0.1)
	queue_free()
