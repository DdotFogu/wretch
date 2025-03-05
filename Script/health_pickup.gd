extends Node3D

@export var health_amount : int = 25
@onready var ground_check: RayCast3D = $"Ground Check"
@onready var health_text = get_node("/root/Main/Hud/Ui/health")
@onready var heal_vignette = get_node("/root/Main/Hud/Ui/heal_vignette")
@onready var health_component = get_node("/root/Main/Player/health_component")

@export var item : Array[Dictionary]
@onready var inv_component = get_node("/root/Main/Player/inventory_component")

func _ready() -> void:
	while ground_check.get_collider() == null:
		await get_tree().create_timer(0.01).timeout
		position.y -= 0.05

func _on_area_3d_body_entered(body: Node3D) -> void:
	if health_component.health == health_component.maxHealth:
		return
	
	inv_component.add_item(item[0])
	
	health_component.health += health_amount
	health_text.apply_shake(0.1)
	heal_vignette.get_node("AnimationPlayer").stop()
	heal_vignette.get_node("AnimationPlayer").play("hurt")
	queue_free()
