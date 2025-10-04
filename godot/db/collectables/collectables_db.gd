extends Resource
class_name CollectablesDB
"""
'DB' para centralizar la config de Collectables y accederlos desde cualquier script
"""

@export var _all_collectable_configs: Array[CollectableConfig]


func get_collectables_by_world(world_type: World.WorldType) -> Array[CollectableConfig]:
	return _all_collectable_configs.filter(func(c: CollectableConfig): return c.world_type == world_type)
