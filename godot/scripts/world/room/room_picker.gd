extends Node
class_name RoomPicker
"""
Selector del siguiente Room a spawnear.
"""

signal interactable_room_spawned()

var _room_configs: Array[RoomConfig] = []
var _rooms_spawned := 0
var _amount_of_rooms_to_spawn: int

var _can_spawn_interactables: bool
var _spawn_interactable_room_requests := 0


var is_warrior: bool

func initialize(world_type: World.WorldType) -> void:
	_room_configs = RoomSpawnerConfigHelper.get_valid_room_configs(world_type)
	_can_spawn_interactables = World.is_miner_world(world_type)
	_amount_of_rooms_to_spawn = GameInfo.get_current_level() + 1 * 5 # TODO

func spawn_interactable_room() -> void:
	_spawn_interactable_room_requests += 1

func pick_room() -> RoomConfig:
	if _rooms_spawned == _amount_of_rooms_to_spawn:
		return _pick_end_room()
	
	var weighted_room: RoomConfig = _pick_weighted_room()
	
	if _can_spawn_interactables && weighted_room.has_interactables: # Miner
		interactable_room_spawned.emit()
	elif _spawn_interactable_room_requests > 0: # Warrior
		_spawn_interactable_room_requests -= 1
		interactable_room_spawned.emit()
	
	_rooms_spawned += 1
	return weighted_room

func _pick_end_room() -> RoomConfig:
	return _room_configs.filter(func(room: RoomConfig): return room.is_end_room).pick_random()

func _pick_weighted_room() -> RoomConfig:
	var total_weight: float = 0.0
	
	for room: RoomConfig in _room_configs:
		total_weight += room.get_appearance_weight()
	
	var rand: float = randf() * total_weight
	var cumulative: float = 0.0
	
	for room: RoomConfig in _room_configs:
		cumulative += room.get_appearance_weight()
		if rand <= cumulative:
			return room

	# Fallback
	return _room_configs.back()



#
