extends AnimatedSprite2D
class_name HeroAnimation


func _ready():
	animation_finished.connect(_on_animation_finished)
	play("walk_up")

func _play_vertical_movement_animation() -> void:
	play("walk_up")

func play_attack_animation() -> void:
	play("attack_up")

func _on_animation_finished():
	if animation == "attack_up":
		play("walk_up")






#
