extends CharacterBody3D

@onready var player = get_node("/root/Main/Player/Body")

@export var nav_agent : NavigationAgent3D
@export var anim_tree : AnimationTree
@export var state_machine : Node

@export var SPEED : float = 8
@export var WALK_SPEED : float = 3
@export var ATTACK_RANGE : float = 5
@export var GRAVITY : float = 20.32

func _physics_process(delta: float) -> void:
	move_and_slide()
