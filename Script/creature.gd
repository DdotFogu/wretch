extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree

@onready var player = get_node("/root/Main/Player/Body")
@onready var state_machine = anim_tree.get("parameters/playback")

const SPEED : float = 4
const ATTACK_RANGE : float = 6

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		"run":
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z), Vector3.UP)
		"attack":
			leap()
			look_at(Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z), Vector3.UP)
	
	anim_tree.set("parameters/conditions/attack", target_in_range())
	anim_tree.set("parameters/conditions/run", !target_in_range())
	
	anim_tree.get("parameters/playback")
	
	move_and_slide()

func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func leap():
	var direction = global_position.direction_to(player.global_position)
	velocity = Vector3(direction * 10)
	await get_tree().create_timer(0.3).timeout
	velocity = Vector3.ZERO
