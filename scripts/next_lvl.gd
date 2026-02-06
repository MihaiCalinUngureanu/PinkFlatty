extends Area2D

# Export this so you can pick the next level in the Inspector for each map
@export_file("*.tscn") var next_level_path

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing entering the box is the Player
	if body.is_in_group("player"): 
		var items_left = get_tree().get_nodes_in_group("collectibles").size()
		
		if items_left == 0:
			if next_level_path != "":
				get_tree().change_scene_to_file(next_level_path)
			else:
				print("No next level assigned!")
		else:
			print("You still need to collect " + str(items_left) + " more items!")
