extends Node
class_name HeroSpawner
"""
Instanciador de Heroes en el nivel
"""

@export var _hero_scene: PackedScene

@export var front_hero_config: HeroConfig
@export var support_hero_config: HeroConfig

@onready var front_hero_spawn_point: Marker2D = $FrontHeroSpawnPoint
@onready var support_hero_spawn_point: Marker2D = $SupportHeroSpawnPoint


func spawn_hero() -> Hero:
	return _spawn_hero(front_hero_config, front_hero_spawn_point)

func _spawn_hero(config: HeroConfig, spawn_point: Marker2D) -> Hero:
	var hero_instance: Hero = _hero_scene.instantiate()
	
	hero_instance.initialize(config)
	add_child(hero_instance)
	hero_instance.global_position = spawn_point.global_position
	return hero_instance
