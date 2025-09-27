extends Resource
class_name RoomsDB
"""
'DB' para centralizar la config de Rooms y accederlos desde cualquier script
"""

@export var _miner_room_configs: Array[RoomConfig]
@export var _warrior_room_configs: Array[RoomConfig]


func get_rooms_by_world(world_type: World.WorldType) -> Array[RoomConfig]:
	match world_type:
		World.WorldType.MINER:
			return _miner_room_configs
		World.WorldType.WARRIOR:
			return _warrior_room_configs
		_:
			push_error("Should not be reachable")
			return []
