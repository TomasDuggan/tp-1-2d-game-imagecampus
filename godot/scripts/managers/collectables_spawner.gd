extends Node
class_name CollectablesSpawner

@export var _collectable_scene: PackedScene
@export var _test_collectable: CollectableConfig # TODO

var _collectables_container: Node2D
var _collectable_spawn_points: CollectableSpawnPoints


func initialize(collectables_container: Node2D, collectable_spawn_points: CollectableSpawnPoints) -> void:
	_collectables_container = collectables_container
	_collectable_spawn_points = collectable_spawn_points
	
	for collectable_spawn_point: Vector2 in _collectable_spawn_points.get_collectable_spawn_points():
		if randf() > 0.9: # TODO
			_instantiate_collectable(collectable_spawn_point)

func _instantiate_collectable(position: Vector2) -> void:
	var collectable_instance: Collectable = _collectable_scene.instantiate()
	
	_collectables_container.add_child(collectable_instance)
	collectable_instance.initialize(_test_collectable)
	collectable_instance.global_position = position
	








#
