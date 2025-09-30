extends AnimatedSprite2D
class_name CollectableAnimation

@onready var _animation_player: AnimationPlayer = $AnimationPlayer

signal death_animation_finished()


func initialize(scale_override: Vector2, frames: SpriteFrames) -> void:
	scale = scale_override
	sprite_frames = frames
	play("default")

func animation_requested(animation_name: String) -> void:
	play(animation_name)
	await animation_finished
	play("default")

func play_hit_animation() -> void:
	_animation_player.play("hit")

func die() -> void:
	if sprite_frames.has_animation("death"):
		play("death")
		await animation_finished
	else:
		_animation_player.play("fade_out")
		await _animation_player.animation_finished
	
	death_animation_finished.emit()






#
