extends Resource
class_name CollectableConfig

@export var type: Enums.CollectableType
@export var hp: int
@export var reward_amount: int
@export var behaviours: Array[PackedScene] # Type: CollectableBehaviour
@export var enemy_config: EnemyCollectableConfig
