extends Area2D
class_name Hurtbox
"""
Escena para recibir dmg de Hitbox
"""

@onready var _hp_bar: ProgressBar = $HPBar

signal hit()
signal healed()
signal destroyed(attacker_root: Node2D, defender_root: Node2D)

enum DamageFaction { HERO, ENEMY }

const FIRE_DAMAGE_REDUCTION_UPGRADE_CONFIG: UpgradeConfig = preload("uid://bmsm7vp5de2fi")


var _root: Node2D
var _max_hp: int
var _current_hp: int
var _faction: DamageFaction
var _hit_sfx: AudioStream
var _fire_damage_reduction: float


func initialize(root: Node2D, hp: int, faction: DamageFaction, show_hp_bar: bool, hit_sfx: AudioStream) -> void:
	_root = root
	_max_hp = hp
	_current_hp = hp
	_faction = faction
	_hit_sfx = hit_sfx
	
	_update_hp_bar()
	if !show_hp_bar:
		_hp_bar.hide()

func _ready():
	_fire_damage_reduction = UpgradesManager.get_modifier_value(
		FIRE_DAMAGE_REDUCTION_UPGRADE_CONFIG.world_type as World.WorldType,
		FIRE_DAMAGE_REDUCTION_UPGRADE_CONFIG.id as UpgradesManager.UpgradeId,
	)

func receive_damage(info: DamageInfo) -> void:
	AudioEventBus.raise_event_play_sfx(_hit_sfx)
	
	var damage: int = _resolve_damage_reduction_by_resistances(info)
	
	_current_hp = max(_current_hp - damage, 0)
	
	_update_hp_bar()
	
	if _current_hp == 0:
		destroyed.emit(info.attacker, _root)
	else:
		hit.emit()

# TODO: si agrego resistencias meter refactor
func _resolve_damage_reduction_by_resistances(info: DamageInfo) -> int:
	if info.damage_type == DamageInfo.DamageType.PHYSICAL:
		return info.damage_amount
	
	return int(info.damage_amount - info.damage_amount * _fire_damage_reduction)

func heal(heal_amount: int) -> void:
	_current_hp = min(_current_hp + heal_amount, _max_hp)
	_update_hp_bar()
	healed.emit()

func _update_hp_bar() -> void:
	_hp_bar.value = _current_hp / float(_max_hp)

func is_ally(other: DamageFaction) -> bool:
	return _faction == other

func deactivate() -> void:
	set_deferred("monitoring", false)




#
