extends Control

@export var randomStrenght: float = 30
@export var shakeFade: float = 5.0
@export var y_offset : float 
@export var x_offset : float
var minScroll : int = 0
var maxScroll : int = 0
var camPosToReturn : Vector2 = Vector2(0, 0)

var rng = RandomNumberGenerator.new() 

var shake_strength: float = 0.0

func apply_shake(strengthMultiplier):
	shake_strength = randomStrenght * strengthMultiplier

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		position = randomOffset()
		position += camPosToReturn
		position.y += y_offset
		position.x += x_offset

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))


func changePos(target : Node, duration : float, zoom : Vector2, offset : Vector2):
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	if target != null:
		tween.tween_property(self, "position", target.position + offset, duration)
	
	var zoomTween = get_tree().create_tween()
	zoomTween.set_ease(Tween.EASE_OUT)
	zoomTween.set_trans(Tween.TRANS_QUART)
	zoomTween.tween_property(self, "zoom", zoom, duration + 0.5)
