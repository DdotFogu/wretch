extends Node3D

var health
@export var hptxt : Label3D
@export var maxHealth : int = 100
@export var regen : bool = false
@export var regenAmount : int = 0.1

var shake_level
var shake_rate

var dead : bool = false
@onready var gibs : Array = [preload("res://scene/fleshgib.tscn")]
@onready var hud : Node = get_node("/root/Main/Hud")

func _ready() -> void:
	randomize()
	health = maxHealth

func _process(delta: float) -> void:
	if hptxt != null:
		hptxt.text = str(health)
	
	if Input.is_action_just_pressed("pi_fire"):
		hurt(5)
	
	if is_in_group("player"):
		hud.get_node("Ui/health").text = "[center][font='res://October Crow.ttf'][shake rate=" + str(shake_rate) + " level=" + str(shake_level) + " connected=0][font_size=32][color=]Health" + "\n" + \
		str(health)
	
	health = clamp(health, 0, maxHealth)

func hurt(amount):
	health -= amount
	health = clampi(health, 0, maxHealth)
	
	if health > 80:
		shake_level = 0
		shake_rate = 50
	elif health <= 80 and !health < 50:
		shake_level = 1
		shake_rate = 50
	elif health <= 50 and !health <30:
		shake_level = 15
		shake_rate = 50
	elif health <= 30 and !health < 15:
		shake_level = 25
		shake_rate = 50
	elif health <= 15:
		shake_level = 45
		shake_rate = 100
	
	if is_in_group("player"):
		hud.get_node("Ui/health").apply_shake(0.2)
		
		hud.get_node("Ui/hurt_vignette/AnimationPlayer").stop()
		hud.get_node("Ui/hurt_vignette/AnimationPlayer").play("hurt")
	
	if health == 0 && dead == false:
		dead = true
		die()

func die():
	if is_in_group("player"):
		$"../Interpolated Camera/Arm/Arm Anchor/viewmodels".visible = false
		$"../Body".Parameters.MAX_SPEED = 0
		$"../Body".Parameters.JUMP_HEIGHT = 0
		$"../Body".Parameters.MOUSE_SENSITIVITY = 0
		$"../Interpolated Camera/Arm/Arm Anchor/Camera Recoil/Camera Shake/Camera".position.y = -1
	if is_in_group("enemy"):
		for count in randi_range(5, 8):
			pass
			#var gib = gibs.pick_random().instantiate()
			#gib.linear_velocity = Vector3(randf_range(-10, 10), randf_range(12, 16), randf_range(-10, 10))
			##gib.rotation = Vector3(randf_range(-360, 360), randf_range(-360, 360), randf_range(-360, 360))
			#gib.position = global_position
			#gib.position.x += randf_range(-1, 1)
			#gib.position.z += randf_range(-1, 1)
			#$"../..".add_child(gib)
			#
			#var blood = preload("res://scene/blood.tscn").instantiate()
			#blood.position = global_position
			#blood.emitting = true
			#blood.position.y += 0.3
			#$"../..".add_child(blood)
			#
			#var bloodtrail = preload("res://scene/bloodtrail.tscn").instantiate()
			#bloodtrail.position = global_position
			#bloodtrail.position.y += 0.3
			#bloodtrail.emitting = true
			#$"../..".add_child(bloodtrail)
		
		get_parent().queue_free()
