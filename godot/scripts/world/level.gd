extends Node
class_name Level

@export var _collectables_spawner: CollectablesSpawner
@export var _collectables_spawn_points: CollectableSpawnPoints
@export var _collectables_container: Node2D


func _ready():
	_collectables_spawner.initialize(_collectables_container, _collectables_spawn_points)
