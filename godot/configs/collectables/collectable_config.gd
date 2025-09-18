extends Resource
class_name CollectableConfig
"""
Config de un collectable destruible por un Hero.
Se le puede agregar comportamiento con 'behaviour_configs'
"""

@export var sprite_frames: SpriteFrames
@export var hp: int
@export var scale_override := Vector2.ONE
@export var destroyed_velocity_boost_duration: float
@export var behaviour_configs: Array[CollectableBehaviourConfig]
