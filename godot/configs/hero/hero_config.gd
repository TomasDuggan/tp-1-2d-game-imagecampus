extends Resource
class_name HeroConfig

@export var hp: int
@export var damage: int
@export var attack_speed: float
@export var horizontal_movement_speed: float


func get_sprite_frames(world_type: World.WorldType) -> SpriteFrames:
	const MINER_ANIMATION = preload("uid://8dvyppn706ka")
	const WARRIOR_ANIMATION = preload("uid://dycf4ffpsmhmr")
	
	return MINER_ANIMATION if World.is_miner_world(world_type) else WARRIOR_ANIMATION
