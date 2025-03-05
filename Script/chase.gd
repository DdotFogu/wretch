extends State
class_name chase

@onready var nav_agent = %NavigationAgent3D
@onready var anim_tree = %AnimationTree

@onready var player = get_node("/root/Main/Player/Body")
@onready var state_machine = anim_tree.get("parameters/playback")

const SPEED : float = 8
const ATTACK_RANGE : float = 2
const GRAVITY : float = 20.32

func update(delta):
	if not $"../..".is_on_floor():
		$"../..".velocity.y -= GRAVITY * delta
		$"../..".move_and_slide()
	else:
		nav_agent.set_target_position(player.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		$"../..".velocity = (next_nav_point - $"../..".global_transform.origin).normalized() * SPEED
		$"../..".rotation.y = lerp($"../..".rotation.y,atan2(-$"../..".velocity.x,-$"../..".velocity.z), .1)
		
		anim_tree.set("parameters/conditions/run", true)
		anim_tree.get("parameters/playback")
		
		if target_in_range() == true:
			Transitioned.emit(self, "attack_meele")
		
		$"../..".move_and_slide()

func exit():
	anim_tree.set("parameters/conditions/attack", true)
	anim_tree.set("parameters/conditions/run", false)

func target_in_range():
	return $"../..".global_position.distance_to(player.global_position) < ATTACK_RANGE
