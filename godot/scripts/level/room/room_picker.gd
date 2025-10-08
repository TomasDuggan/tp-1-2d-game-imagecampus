extends Node
class_name RoomPicker
"""
Selector del siguiente Room a spawnear.
"""

signal end_room_spawned()
signal interactable_room_spawned(amount_of_interactables: int)

var _room_configs: Array[RoomConfig] = []
var _rooms_spawned := 0
var _amount_of_rooms_to_spawn: int
var _last_room_picked: RoomConfig

var _can_spawn_interactables: bool
var _spawn_interactable_room_requests: Array[int] = [] # FIFO, amount of interactables to spawn

const CHANCE_TO_SPAWN_INTERACTABLE_ROOM := 0.35
const AMOUNT_OF_ROOMS_PER_CURRENT_LEVEL_MULTIPLIER := 3
const MIN_ROOMS_PER_LEVEL := 3
const MAX_ROOMS_PER_LEVEL := 9


func initialize(world_type: World.WorldType) -> void:
	_room_configs = RoomSpawnerConfigHelper.get_valid_room_configs(world_type)
	_can_spawn_interactables = World.is_miner_world(world_type)
	
	var rooms_to_spawn: int = LevelProgress.get_current_level_index() * AMOUNT_OF_ROOMS_PER_CURRENT_LEVEL_MULTIPLIER
	_amount_of_rooms_to_spawn = clamp(rooms_to_spawn, MIN_ROOMS_PER_LEVEL, MAX_ROOMS_PER_LEVEL)

func spawn_interactable_room(amount_of_interactables: int) -> void:
	_spawn_interactable_room_requests.append(amount_of_interactables)

func pick_room() -> RoomConfig:
	var special_case_room: RoomConfig = _get_special_case_room()
	if special_case_room != null:
		return special_case_room
	
	_rooms_spawned += 1
	
	var interactables_amount: int = _get_interactables_amount()
	return _pick_weighted_room(interactables_amount)

func _get_special_case_room() -> RoomConfig:
	if _rooms_spawned == 0:
		_rooms_spawned += 1
		return _pick_start_room()
	
	if _rooms_spawned >= _amount_of_rooms_to_spawn:
		end_room_spawned.emit()
		return _pick_end_room()
	
	return null

func _get_interactables_amount() -> int:
	if _can_spawn_interactables && randf() < CHANCE_TO_SPAWN_INTERACTABLE_ROOM && _rooms_spawned < _amount_of_rooms_to_spawn:
		return -1 
	elif !_spawn_interactable_room_requests.is_empty():
		return _spawn_interactable_room_requests.pop_front()
	
	return 0

func _pick_end_room() -> RoomConfig:
	return _room_configs.filter(func(room: RoomConfig): return room.is_end_room).pick_random()

func _pick_start_room() -> RoomConfig:
	return _room_configs.filter(func(room: RoomConfig): return room.is_start_room).pick_random()

func _pick_weighted_room(interactable_request: int) -> RoomConfig:
	var rooms_to_evaluate: Array[RoomConfig] = _get_valid_rooms(interactable_request)
	
	var total_weight: float = 0.0
	for room: RoomConfig in rooms_to_evaluate:
		total_weight += room.get_appearance_weight()
	
	var rand: float = randf() * total_weight # rango total [0, total_weight)
	var cumulative: float = 0.0 # Subrango que abarca en el rango total 'rand', se desplaza en cada iteracion
	
	for room_config: RoomConfig in rooms_to_evaluate:
		cumulative += room_config.get_appearance_weight()
		if rand <= cumulative:
			if room_config.has_interactables():
				interactable_room_spawned.emit(room_config.amount_of_interactables)
			_last_room_picked = room_config
			return room_config
	
	# Fallback
	_last_room_picked = rooms_to_evaluate.back()
	return _last_room_picked

func _get_valid_rooms(interactable_request: int) -> Array[RoomConfig]:
	var rooms: Array[RoomConfig]
	
	if interactable_request == 0: # Sin interactalbes
		rooms = _room_configs.filter(func(r: RoomConfig): return !r.has_interactables())
	elif interactable_request == -1: # Cantidad aleatoria de interactuables
		rooms = _room_configs.filter(func(r: RoomConfig): return r.has_interactables())
	else: # Cantidad fija de interactuables
		rooms = _room_configs.filter(func(r: RoomConfig): return r.amount_of_interactables == interactable_request)
	
	# Puede que sea un Level sin interactuables, hago fallback a rooms "normales" sin interactuables.
	if rooms.is_empty():
		rooms = _filter_interactables(false)
	
	# Para no repetir Rooms pegados
	return rooms.filter(func(r: RoomConfig): return r != _last_room_picked)

func _filter_interactables(force_interactable: bool) -> Array[RoomConfig]:
	return _room_configs.filter(func(r: RoomConfig): return r.has_interactables() == force_interactable)







#
