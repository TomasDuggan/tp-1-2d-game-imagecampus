extends Node
class_name World
"""
Inicializador general del mundo, le pasa configs a sus hijos (Dependencies).
Sirve como entrypoint centralizado para no tener que configurar las cosas en cada dependencia con @export.
"""

@export_category("World Config")
@export var _world_type: World.WorldType
@export var _hero_config: HeroConfig
@export var _collectables_to_spawn: Array[CollectableConfig]

@export_category("Editor Dependencies")
@export var _hero: Hero
@export var _score_container: CollectableUI

enum WorldType { MINER, WARRIOR }


func _ready():
	_hero.initialize(_hero_config, _world_type)
	_score_container.initialize(_world_type)

func get_hero() -> Hero:
	return _hero

func set_ally_hero(ally: Hero) -> void:
	_hero.set_ally(ally)
