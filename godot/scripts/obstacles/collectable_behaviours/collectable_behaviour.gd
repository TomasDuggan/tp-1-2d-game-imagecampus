extends Node2D
class_name CollectableBehaviour
"""
Logica abstracta de un objeto coleccionable
"""

var config: CollectableConfig


func initialize(config_arg: CollectableConfig) -> void:
	config = config_arg

func on_destroyed_by_hero(_source: Hero) -> void:
	pass
