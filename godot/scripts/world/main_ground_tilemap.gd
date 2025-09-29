extends TileMapLayer
class_name MainGroundTileMap
"""
World tiene un tilemap principal que se va generando a partir de los tilemaps de los Rooms
"""

const MERGE_TERRAIN_ID := 0

var _tile_height: int
var _world_type: World.WorldType


func initialize(world_type: World.WorldType) -> void:
	_world_type = world_type

func _ready() -> void:
	_tile_height = tile_set.tile_size.y

func add_new_room_ground_tilemap(room_tilemap: TileMapLayer, room_spawn_point: float) -> void:
	var before_rect: Rect2i = get_used_rect()
	
	_copy_room_tilemap(room_tilemap, room_spawn_point)
	_connect_tilemaps(before_rect)
	
	room_tilemap.queue_free()

func _copy_room_tilemap(room_tilemap: TileMapLayer, room_spawn_point: float) -> void:
	var used_cells: Array[Vector2i] = room_tilemap.get_used_cells()
	var tile_offset := Vector2i(0, int(room_spawn_point / _tile_height))
	
	for cell: Vector2i in used_cells:
		var source_id = room_tilemap.get_cell_source_id(cell)
		var atlas_coords = room_tilemap.get_cell_atlas_coords(cell)
		var target_pos: Vector2i = cell + tile_offset
		
		set_cell(target_pos, source_id, atlas_coords)

func _connect_tilemaps(before_rect: Rect2i) -> void:
	var merge_row_y: int = before_rect.position.y
	var row_cells: Array[Vector2i] = _get_band_cells(before_rect, merge_row_y)
	var terrain_set_id: int = 0 if World.is_miner_world(_world_type) else 1
	
	if !row_cells.is_empty():
		# Para debug. Muestra las cells conectoras:
		#for cell in row_cells:
			#set_cell(cell, 0, Vector2i(9,1))
		set_cells_terrain_connect(row_cells, terrain_set_id, MERGE_TERRAIN_ID)

func _get_band_cells(rect: Rect2i, y: int) -> Array[Vector2i]:
	const TILES_HEIGHT := 3
	var cells: Array[Vector2i] = []

	for dy in range(TILES_HEIGHT):
		for x in range(rect.position.x, rect.position.x + rect.size.x):
			var pos := Vector2i(x, y + dy)
			#if get_cell_source_id(pos) != -1:
			cells.append(pos)

	return cells
