extends Object
class_name RoomSpawnerConfigHelper


static func get_valid_collectable_configs(world_type: World.WorldType) -> Array[CollectableConfig]:
	const COLLECTABLES_DB: CollectablesDB = preload("uid://by8m5vbld0b1g")
	var current_level: int = LevelProgress.get_current_level_index()
	
	return COLLECTABLES_DB.get_collectables_by_world(world_type).filter(func(r: CollectableConfig):
		return r.min_level_to_show <= current_level
	)

static func get_valid_room_configs(world_type: World.WorldType) -> Array[RoomConfig]:
	const ROOMS_DB: RoomsDB = preload("uid://bwy0rnkbodshd")
	var current_level: int = LevelProgress.get_current_level_index()
	
	return ROOMS_DB.get_rooms_by_world(world_type).filter(func(r: RoomConfig):
		return r.min_level_to_show <= current_level
	)
