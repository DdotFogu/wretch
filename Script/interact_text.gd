extends RichTextLabel

var id : int = 0

func doText(bbcode, showText, pitchMin, pitchMax, sizeY):
	position.y = sizeY
	
	id += 1
	var currentId = id
	self.text = bbcode
	for char in showText:
		if id > currentId:
			return
		if char == "|":
			clear()
			self.text = bbcode
			continue
		if char == "/":
			await get_tree().create_timer(0.3).timeout
			continue
		self.text += char
		get_node("Type").pitch_scale = randf_range(pitchMin, pitchMax)
		get_node("Type").play()
		await get_tree().create_timer(0.03).timeout
	await get_tree().create_timer(5).timeout
	print("Text clear")
	clear()
