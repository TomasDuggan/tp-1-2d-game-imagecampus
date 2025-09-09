extends CollectableBehaviour
class_name EnemyCollectableBehaviour

@onready var animation: AnimatedSprite2D = $Animation



func _ready():
	animation.sprite_frames = config.enemy_config.sprite_frames

func _on_attack_area_body_entered(body):
	print("player entered")
