extends Area2D
class_name WinWorldArea

func _ready():
	body_entered.connect(_on_hero_entered)

func _on_hero_entered(hero: Hero) -> void:
	HeroEventBus.raise_event_hero_won_world(hero)
