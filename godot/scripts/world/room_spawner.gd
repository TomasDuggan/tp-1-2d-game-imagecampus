extends Node2D
class_name RoomSpawner

@export_category("Editor Dependencies")
@export var _rooms_container: Node2D 
@export var _main_ground_tilemap: TileMapLayer

const VIEWPORT_HEIGHT := 720.0
const MERGE_TERRAIN_ID := 0

var _world_type: World.WorldType
var _room_configs: Array[RoomConfig] = []
var _collectables_to_spawn: Array[CollectableConfig] = []
var _cursor_y := 0.0



func initialize(world_type: World.WorldType) -> void:
	var current_level: int = GameInfo.get_current_level()
	
	_world_type = world_type
	_collectables_to_spawn = _get_valid_collectable_configs(world_type, current_level)
	_room_configs = _get_valid_room_configs(world_type, current_level)
	
	_spawn_room(Vector2(0, VIEWPORT_HEIGHT))

func _get_valid_collectable_configs(world_type: World.WorldType, current_level: int) -> Array[CollectableConfig]:
	const COLLECTABLES_DB: CollectablesDB = preload("uid://by8m5vbld0b1g")
	return COLLECTABLES_DB.get_collectables_by_world(world_type).filter(func(r: CollectableConfig):
		return r.min_level_to_show <= current_level
	)

func _get_valid_room_configs(world_type: World.WorldType, current_level: int) -> Array[RoomConfig]:
	const ROOMS_DB: RoomsDB = preload("uid://bwy0rnkbodshd")
	return ROOMS_DB.get_rooms_by_world(world_type).filter(func(r: RoomConfig):
		return r.min_level_to_show <= current_level
	)

func _process(_delta: float) -> void:
	if _room_reached_end():
		_spawn_room()

"""
Explicacion x las dudas
* _cursor_y: Acumula el size.y de los rooms, es la Y del próximo room a spawnear en coordenadas del container. 
* -_rooms_container.position.y: La parte superior del container, se mueve con el scroll.
* Restar VIEWPORT_HEIGHT: spawn justo cuando la parte visible alcanza el final del room anterior.
"""
func _room_reached_end() -> bool:
	return _cursor_y > -_rooms_container.position.y - VIEWPORT_HEIGHT

func _spawn_room(pos: Vector2 = Vector2.ZERO) -> void:
	var room_config: RoomConfig = _room_configs.pick_random()
	var room_instance: Room = room_config.scene.instantiate()
	
	room_instance.initialize(_collectables_to_spawn)
	_rooms_container.add_child(room_instance)
	room_instance.global_position = pos
	
	_add_new_room_ground_tilemap(room_instance.get_map())
	
	_cursor_y -= room_instance.get_room_height()

func _add_new_room_ground_tilemap(room_tilemap: TileMapLayer) -> void:
	var before_rect: Rect2i = _main_ground_tilemap.get_used_rect()
	
	_copy_room_tilemap(room_tilemap)
	_connect_tilemaps(before_rect)
	
	room_tilemap.queue_free()

func _copy_room_tilemap(room_tilemap: TileMapLayer) -> void:
	var used_cells: Array[Vector2i] = room_tilemap.get_used_cells()
	var offset := Vector2i(0, int(_cursor_y / _main_ground_tilemap.tile_set.tile_size.y))
	
	for cell: Vector2i in used_cells:
		var source_id = room_tilemap.get_cell_source_id(cell)
		var atlas_coords = room_tilemap.get_cell_atlas_coords(cell)
		var target_pos: Vector2i = cell + offset
		
		_main_ground_tilemap.set_cell(target_pos, source_id, atlas_coords)

func _connect_tilemaps(before_rect: Rect2i) -> void:
	var merge_row_y: int = before_rect.position.y
	var row_cells: Array[Vector2i] = _get_band_cells(before_rect, merge_row_y)
	var terrain_set_id: int = 0 if World.is_miner_world(_world_type) else 1
	
	if row_cells.size() > 0:
		_main_ground_tilemap.set_cells_terrain_connect(row_cells, terrain_set_id, MERGE_TERRAIN_ID)

func _get_band_cells(rect: Rect2i, y: int) -> Array[Vector2i]:
	const TILES_HEIGHT := 3
	var cells: Array[Vector2i] = []

	for dy in range(TILES_HEIGHT):
		for x in range(rect.position.x, rect.position.x + rect.size.x):
			var pos := Vector2i(x, y + dy)
			if _main_ground_tilemap.get_cell_source_id(pos) != -1:
				cells.append(pos)

	return cells









#
