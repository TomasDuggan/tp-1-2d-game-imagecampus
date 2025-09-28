extends Node
class_name RoomPicker
"""
Selector del siguiente Room a spawnear.
"""

signal end_room_spawned()
signal interactable_room_spawned()

var _room_configs: Array[RoomConfig] = []
var _rooms_spawned := 0
var _amount_of_rooms_to_spawn: int

var _can_spawn_interactables: bool
var _spawn_interactable_room_requests := 0

const CHANCE_TO_SPAWN_INTERACTABLE_ROOM := 0.5


func initialize(world_type: World.WorldType) -> void:
	_room_configs = RoomSpawnerConfigHelper.get_valid_room_configs(world_type)
	_can_spawn_interactables = World.is_miner_world(world_type)
	_amount_of_rooms_to_spawn = GameInfo.get_current_level() + 1 * 5 # TODO

func spawn_interactable_room() -> void:
	_spawn_interactable_room_requests += 1

func pick_room() -> RoomConfig:
	var special_case_room: RoomConfig = _get_special_case_room()
	if special_case_room != null:
		return special_case_room
	
	_rooms_spawned += 1
	
	var force_interactable: bool = _should_spawn_interactable_room()
	return _pick_weighted_room(force_interactable)

# Extremos: start y end rooms
func _get_special_case_room() -> RoomConfig:
	if _rooms_spawned == 0:
		_rooms_spawned += 1
		return _pick_start_room()
	
	if _rooms_spawned == _amount_of_rooms_to_spawn:
		end_room_spawned.emit()
		return _pick_end_room()
	
	return null

func _should_spawn_interactable_room() -> bool:
	if _can_spawn_interactables && randf() < CHANCE_TO_SPAWN_INTERACTABLE_ROOM: # Miner
		interactable_room_spawned.emit()
		return true
	elif _spawn_interactable_room_requests > 0: # Warrior
		_spawn_interactable_room_requests -= 1
		return true
	
	return false

func _pick_end_room() -> RoomConfig:
	return _room_configs.filter(func(room: RoomConfig): return room.is_end_room).pick_random()

func _pick_start_room() -> RoomConfig:
	return _room_configs.filter(func(room: RoomConfig): return room.is_start_room).pick_random()

func _pick_weighted_room(force_interactable: bool) -> RoomConfig:
	var rooms_to_evaluate: Array[RoomConfig] = _filter_interactables(force_interactable)
	var total_weight: float = 0.0
	
	for room: RoomConfig in rooms_to_evaluate:
		total_weight += room.get_appearance_weight()
	
	var rand: float = randf() * total_weight
	var cumulative: float = 0.0
	
	for room: RoomConfig in rooms_to_evaluate:
		cumulative += room.get_appearance_weight()
		if rand <= cumulative:
			return room

	# Fallback
	return rooms_to_evaluate.back()

func _filter_interactables(force_interactable: bool) -> Array[RoomConfig]:
	return _room_configs.filter(func(r: RoomConfig): return r.has_interactables == force_interactable)


#
