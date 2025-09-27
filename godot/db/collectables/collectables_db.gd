extends Resource
class_name CollectablesDB
"""
'DB' para centralizar la config de Collectables y accederlos desde cualquier script
"""

@export var _miner_collectable_configs: Array[CollectableConfig]
@export var _warrior_collectable_configs: Array[CollectableConfig]


func get_collectables_by_world(world_type: World.WorldType) -> Array[CollectableConfig]:
	match world_type:
		World.WorldType.MINER:
			return _miner_collectable_configs
		World.WorldType.WARRIOR:
			return _warrior_collectable_configs
		_:
			push_error("Should not be reachable")
			return []
	
