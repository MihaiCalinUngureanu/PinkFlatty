extends Node2D

# Current level instance
var current_level = null

func _ready() -> void:
	# Get the first level from LevelContainer
	if $LevelContainer.get_child_count() > 0:
		current_level = $LevelContainer.get_child(0)
		# Connect to GameManager's level_completed signal
		GameManager.level_completed.connect(_on_level_completed)
		_setup_level()

func change_level(next_level_path: String):
	# Remove old level
	if current_level:
		current_level.queue_free()
	
	# Load and instantiate new level
	var level_resource = load(next_level_path)
	var new_level = level_resource.instantiate()
	
	# Add to LevelContainer (FIXED: was adding to wrong parent)
	$LevelContainer.add_child(new_level)
	new_level.name = "Level_1"
	
	# Update reference
	current_level = new_level
	
	# Reset GameManager score for new level
	GameManager.score = 0
	
	# Setup new level
	_setup_level()

func _setup_level() -> void:
	# Count collectibles and set target score
	var collectibles = current_level.get_node_or_null("Collectibles")
	if collectibles:
		GameManager.target_score = collectibles.get_child_count()
		print("Target score set to: ", GameManager.target_score)
	
	# Connect enemy signals
	var enemies = current_level.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			if not enemy.player_died.is_connected(_on_player_died):
				enemy.player_died.connect(_on_player_died)

func _on_level_completed():
	print("Level completed! Changing to next level...")
	change_level("res://scenes/Levels/level_2.tscn")

func _on_player_died(body):
	body.die()
	print("Player died")
