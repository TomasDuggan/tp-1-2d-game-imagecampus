extends Node
class_name LevelEndManager
"""
Chequea y levanta evento de Level ganado o perdido
"""

const TOTAL_AMOUNT_OF_HEROES := 2

var _heroes_that_won_world: Array[Hero] = []

func _ready():
	HeroEventBus.hero_won_world.connect(_on_hero_won_world)
	HeroEventBus.hero_lost_world.connect(_on_hero_lost_world)

func _on_hero_won_world(hero: Hero) -> void:
	if _heroes_that_won_world.has(hero):
		return
	
	_heroes_that_won_world.append(hero)
	
	if _heroes_that_won_world.size() == TOTAL_AMOUNT_OF_HEROES:
		get_tree().paused = true
		LevelEventBus.raise_event_level_won()

func _on_hero_lost_world(_hero: Hero) -> void:
	get_tree().paused = true
	LevelEventBus.raise_event_level_lost()

func _exit_tree():
	HeroEventBus.hero_won_world.disconnect(_on_hero_won_world)
	HeroEventBus.hero_lost_world.disconnect(_on_hero_lost_world)

func _on_go_to_shop_button_pressed():
	SceneLoadManager.load_shop()
