extends Resource
class_name CollectableConfig
"""
Config de un collectable destruible por un Hero.
Se le puede agregar comportamiento con 'behaviour_configs'
"""

@export var world_type: World.WorldType
@export var sprite_frames: SpriteFrames
@export var hp: int
@export var scale_override := Vector2.ONE
@export var destroyed_velocity_boost_duration: float
@export var behaviour_configs: Array[CollectableBehaviourConfig]
@export var min_level_to_show: int


func get_hit_sfx() -> AudioStream:
	return preload("uid://bkbh6d7gwaxh6") if World.is_miner_world(world_type) else preload("uid://btpk3g3l6nusm")



#
