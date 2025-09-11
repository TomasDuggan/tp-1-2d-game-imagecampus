extends Node
class_name CollectablesSpawner

@export var _collectable_scene: PackedScene
@export var _collectables_container: Node2D
@export var _collectable_spawn_points: CollectableSpawnPoints


func initialize(collectables_to_spawn: Array[CollectableConfig]) -> void:
	for collectable_spawn_point: Vector2 in _collectable_spawn_points.get_collectable_spawn_points():
		if randf() > 0.95: # TODO
			_instantiate_collectable(collectables_to_spawn.pick_random(), collectable_spawn_point)

func _instantiate_collectable(collectable_config: CollectableConfig, position: Vector2) -> void:
	var collectable_instance: Collectable = _collectable_scene.instantiate()
	
	collectable_instance.initialize(collectable_config)
	_collectables_container.add_child(collectable_instance)
	collectable_instance.position = position
	








#
