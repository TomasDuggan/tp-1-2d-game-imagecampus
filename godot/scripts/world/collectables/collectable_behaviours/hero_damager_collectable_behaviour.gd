extends CollectableBehaviour
class_name HeroDamagerCollectableBehaviour

@onready var _hitbox: Hitbox = $Hitbox

func _ready():
	var hero_damager_config := config as HeroDamagerBehaviourConfig
	_hitbox.initialize(self, hero_damager_config.damage, hero_damager_config.attack_speed, true, Hurtbox.DamageFaction.ENEMY, DamageInfo.DamageType.PHYSICAL, 0.0)
	_hitbox.attack_performed.connect(_on_attack_performed)

func _on_attack_performed() -> void:
	request_animation.emit("attack")

func on_destroyed_by_hero(_source: Hero) -> void:
	pass
