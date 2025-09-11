extends Node
class_name World

@export var _config: WorldConfig
@export var _collectables_spawner: CollectablesSpawner
@export var _hero: Hero


func _ready():
	_collectables_spawner.initialize(_config.collectables_to_spawn)
	_hero.initialize(_config.hero_config)
