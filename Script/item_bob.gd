extends Node3D

@export var BOB_FREQUENCY = 0.008
@onready var arm_anchor: Node3D = $".."
@onready var body: GoldGdt_Body = $"../../../../../Body"

func _physics_process(delta: float) -> void:
	_camera_mount_bob()

func _camera_mount_bob() -> void:
	var bob : float
	var simvel : Vector3
	simvel = body.velocity
	simvel.y = 0
	
	if BOB_FREQUENCY == 0.0 or BOB_FREQUENCY == 0:
		return
	
	if body.is_on_floor():
		bob = lerp(0.0, sin(Time.get_ticks_msec() * BOB_FREQUENCY) / BOB_FREQUENCY, (simvel.length() / 2.0) / body.Parameters.FORWARD_SPEED) * 0.0001
	else:
		bob = 0.0
	arm_anchor.position.y = lerp(arm_anchor.position.y, bob, 0.5)
