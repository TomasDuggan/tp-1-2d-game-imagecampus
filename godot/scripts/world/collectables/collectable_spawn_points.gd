extends TileMapLayer
class_name CollectableSpawnPoints

func _ready():
	set_visible(false)

func get_collectable_spawn_points() -> Array[Vector2]:
	var spawn_points: Array[Vector2] = []
	
	for cell: Vector2i in get_used_cells():
		spawn_points.append(map_to_local(cell))
	
	return spawn_points
