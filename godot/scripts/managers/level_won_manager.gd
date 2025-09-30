extends Node
class_name LevelWonManager
"""
Chequea y levanta evento de Level ganado
"""

@export_category("Editor Dependencies")
@export var _level_won_menu: Control

const TOTAL_AMOUNT_OF_HEROES := 2

var _heroes_that_won_world: Array[Hero] = []


func _ready():
	HeroEventBus.hero_won_world.connect(_on_hero_won_world)
	_level_won_menu.hide()

func _on_hero_won_world(hero: Hero) -> void:
	if _heroes_that_won_world.has(hero):
		return
	
	_heroes_that_won_world.append(hero)
	
	if _heroes_that_won_world.size() == TOTAL_AMOUNT_OF_HEROES:
		get_tree().paused = true
		_level_won_menu.show()
		LevelEventBus.raise_event_level_won()

func _exit_tree():
	HeroEventBus.hero_won_world.disconnect(_on_hero_won_world)
