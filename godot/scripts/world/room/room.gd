extends Node2D
class_name Room

@export_category("Editor Dependencies")
@export var _collectables_spawner: CollectablesSpawner2

func initialize(collectables_to_spawn: Array[CollectableConfig]) -> void:
	_collectables_spawner.initialize(collectables_to_spawn)
