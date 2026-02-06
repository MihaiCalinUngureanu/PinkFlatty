extends Label

func _process(_delta):
	# Every frame, update the text to match the global score
	text = "Apples: " + str(GameManager.score)
