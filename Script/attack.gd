extends State
class_name attack_meele

@onready var nav_agent = %NavigationAgent3D
@onready var anim_tree = %AnimationTree

@onready var player = get_node("/root/Main/Player/Body")
@onready var state_machine = anim_tree.get("parameters/playback")

const ATTACK_RANGE : float = 2
const GRAVITY : float = 20.32

func enter():
	$"../..".velocity = Vector3.ZERO
	await get_tree().create_timer(1).timeout
	Transitioned.emit(self, "chase")

func exit():
	anim_tree.set("parameters/conditions/run", true)
	anim_tree.set("parameters/conditions/attack", false)

func update(delta):
	if not $"../..".is_on_floor():
		$"../..".velocity.y -= GRAVITY * delta
	$"../..".move_and_slide()

func leap():
	pass
	#$"../..".collision_mask = 5
	#var direction = $"../..".global_position.direction_to(player.global_position)
	#$"../..".velocity = Vector3(direction * 20)
	#await get_tree().create_timer(0.5).timeout
	#$"../..".collision_mask = 7
	#$"../..".velocity = Vector3.ZERO
