extends Resource
class_name CollectableConfig

@export var texture: Texture2D
@export var type: Enums.CollectableType
@export var hp: int
@export var reward_amount: int
@export var destroyed_velocity_boost_duration: float
@export var behaviours: Array[PackedScene] # Type: CollectableBehaviour
