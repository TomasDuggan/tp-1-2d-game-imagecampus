extends TileMapLayer
class_name CollectablesSpawner

@export_category("Editor Dependencies")
@export var _collectables_container: Node2D

const COLLECTABLE_SCENE: PackedScene = preload("uid://ctkc2ceeqspqm")


func _ready():
	set_visible(false)

func initialize(collectables_to_spawn: Array[CollectableConfig]) -> void:
	for collectable_spawn_point: Vector2 in _get_collectable_spawn_points():
		if randf() > 0.95: # TODO
			_instantiate_collectable(collectables_to_spawn.pick_random(), collectable_spawn_point)

func _instantiate_collectable(collectable_config: CollectableConfig, pos: Vector2) -> void:
	var collectable_instance: Collectable = COLLECTABLE_SCENE.instantiate()
	
	collectable_instance.initialize(collectable_config)
	_collectables_container.add_child(collectable_instance)
	collectable_instance.position = pos

func _get_collectable_spawn_points() -> Array[Vector2]:
	var spawn_points: Array[Vector2] = []
	
	for cell: Vector2i in get_used_cells():
		spawn_points.append(map_to_local(cell))
	
	return spawn_points
