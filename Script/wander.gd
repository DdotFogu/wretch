extends State
class_name wander

@onready var body = $"../.."
@onready var wander_point: PathFollow3D = $"../../wander_area/wander_point"
@onready var vision: Area3D = $"../../vision"

@export var timer : Timer
var target_position : Vector3

func enter():
	timer.start()

func exit():
	pass

func update(delta):
	if not body.is_on_floor():
		body.velocity.y -= body.GRAVITY * delta
	else:
		body.nav_agent.set_target_position(target_position)
		var next_nav_point = body.nav_agent.get_next_path_position() * body.WALK_SPEED
		body.velocity = (next_nav_point - body.global_transform.origin).normalized()
		body.rotation.y = lerp(body.rotation.y,atan2(-body.velocity.x,-body.velocity.z), .1)
		
		if body.velocity.x < 1 and body.velocity.z < 1:
			body.velocity.x = 0
			body.velocity.z = 0
			Transitioned.emit(self, "idle")
		else:
			body.anim_tree.get("parameters/playback").travel("Run")

func _on_timer_timeout() -> void:
	Transitioned.emit(body.state_machine.current_state, "wander")
	
	wander_point.progress_ratio = randf_range(0, 1)
	target_position = wander_point.global_position
	
	timer.wait_time = randf_range(5, 10)

func saw_player(player: Node3D) -> void:
	timer.stop()
	vision.monitoring = false
	Transitioned.emit(body.state_machine.current_state, "chase")
