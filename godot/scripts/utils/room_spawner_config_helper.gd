extends Object
class_name RoomSpawnerConfigHelper

const COLLECTABLES_DB: CollectablesDB = preload("uid://by8m5vbld0b1g")
const ROOMS_DB: RoomsDB = preload("uid://bwy0rnkbodshd")


static func get_valid_collectable_configs(world_type: World.WorldType) -> Array[CollectableConfig]:
	var current_level: int = LevelProgress.get_current_level_index()
	
	return COLLECTABLES_DB.get_collectables_by_world(world_type).filter(func(c: CollectableConfig):
		return c.min_level_to_show <= current_level && c.max_level_to_show >= current_level
	)

static func get_valid_room_configs(world_type: World.WorldType) -> Array[RoomConfig]:
	var current_level: int = LevelProgress.get_current_level_index()
	
	return ROOMS_DB.get_rooms_by_world(world_type).filter(func(r: RoomConfig):
		return r.min_level_to_show <= current_level && r.max_level_to_show >= current_level
	)
