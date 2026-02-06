extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	# Check if player collected the apple
	if body.is_in_group("player"):
		# Play collection animation and sound
		animated_sprite_2d.play("colectat")
		audio_stream_player_2d.play()
		
		# Add score to GameManager
		GameManager.add_score(1)
		
		# Wait for animation to finish, then remove apple
		await animated_sprite_2d.animation_finished
		queue_free()
