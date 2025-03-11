extends State
class_name idle

@onready var body = $"../.."

func enter():
	body.anim_tree.get("parameters/playback").travel("Idle")

func exit():
	pass

func update(delta):
	if not body.is_on_floor():
		body.velocity.y -= body.GRAVITY * delta
