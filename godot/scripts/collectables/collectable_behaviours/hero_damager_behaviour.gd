extends CollectableBehaviour
class_name HeroDamagerCollectableBehaviour

@onready var _hitbox: Hitbox = $Hitbox

func _ready():
	var hero_damager_config := config as HeroDamagerBehaviourConfig
	_hitbox.initialize(self, hero_damager_config.damage, hero_damager_config.attack_speed, true, Enums.DamageFaction.ENEMY)
