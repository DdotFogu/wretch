extends StaticBody3D

enum state {Open, Closed}
@export var door_state = state.Closed
enum color {Red, Green, Blue, Yellow}
@export var door_color = color.Red

@onready var inv_component = get_node("/root/Main/Player/inventory_component")

func play():
	var color_to_check : String
	var key_name : String
	match door_color:
		color.Red:
			color_to_check = "red"
		color.Blue:
			color_to_check = "blue"
		color.Green:
			color_to_check = "green"
		color.Yellow:
			color_to_check = "yellow"
	
	key_name = color_to_check + " key"
	print(key_name)
	
	if door_state == state.Closed:
		door_state = state.Open
		
		for item in inv_component.items:
			print(item["color"])
			if item["color"] == color_to_check:
				inv_component.remove_item(key_name)
				$AnimationPlayer.play("open")
