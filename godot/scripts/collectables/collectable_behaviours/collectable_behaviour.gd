extends Node2D
class_name CollectableBehaviour
"""
Logica abstracta del comportamiento de un objeto coleccionable
"""

var config: CollectableBehaviourConfig


func initialize(config_arg: CollectableBehaviourConfig) -> void:
	config = config_arg

func on_destroyed_by_hero(_source: Hero) -> void:
	pass
