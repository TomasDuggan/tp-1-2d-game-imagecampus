extends Node2D
class_name Room
"""
Un Room es un 'trozo' de un nivel. Los encadeno para hacer un nivel pseudo-procedural.
Cada Room es una escena separada.
"""

@export_category("Editor Dependencies")
@export var _collectables_spawner: RandomCollectableSpawner
@export var _map: TileMapLayer


func initialize(collectables_to_spawn: Array[CollectableConfig]) -> void:
	_collectables_spawner.initialize(collectables_to_spawn)

func get_room_height() -> float:
	return _map.get_used_rect().size.y * _map.tile_set.tile_size.y

func get_map() -> TileMapLayer:
	return _map







#
