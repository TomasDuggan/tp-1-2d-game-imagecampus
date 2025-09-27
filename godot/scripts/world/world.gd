extends Node
class_name World

@export_category("Editor Dependencies")
@export var _room_spawner: RoomSpawner
@export var _hero: Hero
@export var _score_container: CollectableUI

@warning_ignore("unused_signal")
signal interactable_room_spawned()

enum WorldType { MINER, WARRIOR }


func initialize(world_type: World.WorldType, hero_config: HeroConfig, ally_hero: Hero) -> void:
	_hero.initialize(hero_config, world_type)
	_hero.set_ally(ally_hero)
	
	_room_spawner.interactable_room_spawned.connect(interactable_room_spawned.emit)
	_room_spawner.initialize(world_type)
	
	_score_container.initialize(world_type)

func get_hero() -> Hero:
	return _hero

# Pasamanos
func spawn_interactable_room() -> void:
	_room_spawner.spawn_interactable_room()

static func is_miner_world(world_type: WorldType) -> bool:
	return world_type == WorldType.MINER

static func is_warrior_world(world_type: WorldType) -> bool:
	return world_type == WorldType.WARRIOR
