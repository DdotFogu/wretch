extends Node3D

@export var Weapons : Array[Dictionary]
var currentWeapon = null
var canfire = true
var time : float = 0
@onready var ammo_text = get_node("/root/Main/Hud/Ui/ammo")

@onready var camera_recoil: Node3D = $"../Interpolated Camera/Arm/Arm Anchor/Camera Recoil"
@onready var camera_shake: Node3D = $"../Interpolated Camera/Arm/Arm Anchor/Camera Recoil/Camera Shake"

func _ready() -> void:
	currentWeapon = Weapons[0]

func _process(delta: float) -> void:
	if currentWeapon != null:
		ammo_text.visible = true
		get_node(currentWeapon["viewmodel"]).visible = true
		get_node(currentWeapon["crosshair"]).visible = true
		
		if currentWeapon["ammo"] != null:
			ammo_text.text = "[center][font='res://October Crow.ttf'][shake rate=50.0 level=0 connected=0][font_size=24][color=]" + get_node(currentWeapon["viewmodel"]).name + "\n" + \
			str(currentWeapon["ammo"])
		
		if Input.is_action_pressed("pi_fire") && canfire == true:
			
			if currentWeapon["ammo"] != null:
				if currentWeapon["ammo"] > 0:
					pass
				else:
					return
				ammo_text.apply_shake(0.5)
				currentWeapon["ammo"] -= 1
			
			
			if currentWeapon["hitscan"] == true:
				if currentWeapon["autofire"] == true:
					fire_gun_hitscan() 
				else:
					fire_gun_hitscan()
			elif currentWeapon["hitscan"] == false:
				if currentWeapon["autofire"] == true:
					fire_gun_proj() 
				else:
					fire_gun_proj()
	else:
		ammo_text.visible = false
	
	if Input.is_action_pressed("pm_moveleft"):
		var tween = get_tree().create_tween()
		tween.tween_property($"../Interpolated Camera/Arm/Arm Anchor/viewmodels", "position:x", -0.03, 0.3)
	elif Input.is_action_pressed("pm_moveright"):
		var tween = get_tree().create_tween()
		tween.tween_property($"../Interpolated Camera/Arm/Arm Anchor/viewmodels", "position:x", 0.03, 0.3)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property($"../Interpolated Camera/Arm/Arm Anchor/viewmodels", "position:x", 0, 0.3)

func fire_gun_hitscan():
	canfire = false
	%waitTime.wait_time = currentWeapon["firerate"]
	%waitTime.start()
	camera_shake.add_trauma(1)
	camera_recoil.recoilFire(false)
	
	get_node(currentWeapon["viewmodel"]).get_node("AnimationPlayer").play("shoot")
	
	var bulletRays : Array[RayCast3D]
	for count in currentWeapon["bullets"]:
		var raycast = RayCast3D.new()
		bulletRays.append(raycast)
		
		raycast.position = $"../Body".global_position
		raycast.rotation = $"../Interpolated Camera".rotation
		raycast.target_position.z = -25
		raycast.target_position.x = randf_range(-currentWeapon["spread"], currentWeapon["spread"])
		raycast.target_position.y = randf_range(-currentWeapon["spread"], currentWeapon["spread"])
		raycast.collision_mask = 4
		
		get_node("/root/Main").add_child(raycast)
		
	await get_tree().create_timer(0.1).timeout
	for raycast in bulletRays:
		if raycast.is_colliding():
			#var blood = preload("res://scene/blood.tscn").instantiate()
			#blood.position = raycast.get_collision_point()
			#get_node("/root/Main").add_child(blood)
			#blood.emitting = true
			raycast.get_collider().get_node("health_component").hurt(currentWeapon["damage"])
		raycast.queue_free()
	bulletRays.clear()

func fire_gun_proj():
	canfire = false
	%waitTime.wait_time = currentWeapon["firerate"]
	%waitTime.start()
	camera_shake.add_trauma(1)
	camera_recoil.recoilFire(false)
	
	get_node(currentWeapon["viewmodel"]).get_node("AnimationPlayer").play("shoot")
	
	for count in currentWeapon["bullets"]:
		var proj = currentWeapon["projectile"].instantiate()
		var spawn_pos = get_node(currentWeapon["viewmodel"]).get_node("launch_point").global_position
		proj.position = spawn_pos
		get_node("/root/Main").add_child(proj)

func _on_wait_time_timeout() -> void:
	canfire = true
