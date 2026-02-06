extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	# This works regardless of what the node is named
	if body.is_in_group("player"):
		animated_sprite_2d.play("colectat")
		audio_stream_player_2d.play()
		GameManager.add_score(1)
		await animated_sprite_2d.animation_finished
		queue_free()
