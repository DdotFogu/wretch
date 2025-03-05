extends Node3D

var items : Array[Dictionary]
@onready var items_hud : Control = get_node("/root/Main/Hud/Ui/items")

func add_item(item_to_add):
	
	items.append(item_to_add)
	
	print(item_to_add["name"])
	
	var item_texture = TextureRect.new()
	item_texture.name = item_to_add["name"]
	item_texture.texture = item_to_add["image"]
	item_texture.position.x += 50 * items_hud.get_child_count()
	item_texture.scale = Vector2(0.4, 0.4)
	items_hud.add_child(item_texture)
	
	
	if item_to_add["fade out"] == true:
		item_to_add["fade out"] == false
		var tween = get_tree().create_tween()
		tween.tween_property(item_texture, "modulate:a", 0, 1)
		
		await get_tree().create_timer(1).timeout
		
		item_texture.queue_free()
		
		var item_child_index = item_texture.get_index()
		for child in items_hud.get_children():
			if child.get_index() > item_child_index:
				child.position.x  -= 50
		items.erase(item_to_add)
		

func remove_item(item_name : String):
	for item in items:
		if item["name"] == item_name:
			items.erase(item)
	
	for child in items_hud.get_children():
		if child.name == item_name:
			child.queue_free()
