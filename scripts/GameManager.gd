extends Node

# Current score (number of apples collected)
var score = 0

# Target score needed to complete the level (set by main.gd based on collectibles count)
var target_score = 5

# Signal emitted when level is completed
signal level_completed

func add_score(amount):
	score += amount
	print("Score: ", score, "/", target_score)
	
	# Check if level is completed
	if score >= target_score and target_score > 0:
		level_completed.emit()
		print("Level completed signal emitted!")
