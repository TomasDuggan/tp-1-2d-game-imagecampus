extends TileMapLayer
class_name CollectablesSpawner
"""
Spawner de collectables
"""

@export_category("Editor Dependencies")
@export var _collectables_container: Node2D

const COLLECTABLE_SCENE: PackedScene = preload("uid://ctkc2ceeqspqm")


func _ready():
	set_visible(false)

func initialize(collectables_to_spawn: Array[CollectableConfig]) -> void:
	for collectable_spawn_point: Vector2 in _get_collectable_random_spawn_points():
		_instantiate_collectable(_pick_weighted_collectable(collectables_to_spawn), collectable_spawn_point)

# TODO: repito codigo con RoomPicker, pero para refactor deberia interfacear (peor aun: herencia pq godot no tiene interfaces) los objetos por solo un campo o usar duck typing, dos opciones feas.
func _pick_weighted_collectable(collectables: Array[CollectableConfig]) -> CollectableConfig:
	var total_weight := 0.0
	for c: CollectableConfig in collectables:
		total_weight += c.appearance_weight
	
	var rand: float = randf() * total_weight
	var cumulative := 0.0
	
	for c: CollectableConfig in collectables:
		cumulative += c.appearance_weight
		if rand <= cumulative:
			return c
	
	# Fallback
	return collectables.front()

func _instantiate_collectable(collectable_config: CollectableConfig, pos: Vector2) -> void:
	var collectable_instance: Collectable = COLLECTABLE_SCENE.instantiate()
	
	collectable_instance.initialize(collectable_config)
	_collectables_container.add_child(collectable_instance)
	collectable_instance.position = pos

func _get_collectable_random_spawn_points() -> Array[Vector2]:
	var spawn_points: Array[Vector2] = []
	
	for cell: Vector2i in get_used_cells():
		spawn_points.append(map_to_local(cell))
	
	return spawn_points
