extends Node3D

@export var ammo_amount : int = 10
@onready var ground_check: RayCast3D = $"Ground Check"
@onready var ammo_text = get_node("/root/Main/Hud/Ui/ammo")
var weapon_component

@export var item : Array[Dictionary]
@onready var inv_component = get_node("/root/Main/Player/inventory_component")

func _ready() -> void:
	weapon_component = get_node("/root/Main/Player/weapon_component")
	
	while ground_check.get_collider() == null:
		await get_tree().create_timer(0.01).timeout
		position.y -= 0.05

func _on_area_3d_body_entered(body: Node3D) -> void:
	if weapon_component.currentWeapon["ammo"] == weapon_component.currentWeapon["max ammo"]:
		return
	
	inv_component.add_item(item[0])
	
	weapon_component.currentWeapon["ammo"] += ammo_amount
	weapon_component.currentWeapon["ammo"] = clamp(weapon_component.currentWeapon["ammo"], 0, weapon_component.currentWeapon["max ammo"])
	ammo_text.apply_shake(0.1)
	queue_free()
