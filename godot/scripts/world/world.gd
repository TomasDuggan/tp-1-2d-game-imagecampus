extends Node
class_name World
"""
Inicializador general del mundo, le pasa configs a sus hijos (dependencias).
Sirve como entrypoint para no tener que configurar las cosas en cada hijo que necesite.
"""

@export_category("World Config")
@export var _collectable_type: Enums.CollectableType
@export var _hero_config: HeroConfig
@export var _collectables_to_spawn: Array[CollectableConfig]

@export_category("Dependencies")
@export var _collectables_spawner: CollectablesSpawner
@export var _hero: Hero
@export var _score_container: ScoreUI

func _ready():
	_collectables_spawner.initialize(_collectables_to_spawn)
	_hero.initialize(_hero_config)
	_score_container.initialize(_collectable_type)

func get_hero() -> Hero:
	return _hero

func set_hero_ally(ally: Hero) -> void:
	_hero.set_ally(ally)
