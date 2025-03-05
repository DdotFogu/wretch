extends Node3D

@export var bbcode : String 
@export var text : String

@onready var interactText = get_node("/root/Main/CanvasLayer/InteractText")
@onready var canvas_layer = get_node("/root/Main/CanvasLayer")

var id : int = 0

func play():
	$"../Cock".pitch_scale = randf_range(0.9, 1.1)
	$"../Cock".play()
	$"..".visible = false
	get_node("/root/Main/Player/weapon_component").currentWeapon = get_node("/root/Main/Player/weapon_component").Weapons[0]
	$CollisionShape3D.disabled = true
	
	canvas_layer.get_node("InteractText").doText(bbcode, text, 0.9, 1.1, 419)
