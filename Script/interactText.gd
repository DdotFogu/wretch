extends Node3D

@export var bbcode : String 
@export var text : String
@export var sizeY : int

@onready var canvas_layer = get_node("/root/Main/CanvasLayer")

func play():
	canvas_layer.get_node("InteractText").doText(bbcode, text, 0.9, 1.1, sizeY)
