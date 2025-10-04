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

const FLOATING_LABEL_SCENE: PackedScene = preload("uid://dtaor3dpc268a")

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
	var fire_damage_reduction_upgrade_config: UpgradeConfig = load("uid://bmsm7vp5de2fi")
	
	_fire_damage_reduction = UpgradesManager.get_modifier_value(
		fire_damage_reduction_upgrade_config.world_type as World.WorldType,
		fire_damage_reduction_upgrade_config.id as UpgradesManager.UpgradeId,
	)

func receive_damage(info: DamageInfo) -> void:
	_trigger_damage_effects(info.is_crit)
	_deal_damage_to_hp(info)
	_check_signal_emmisions(info.attacker)

func _trigger_damage_effects(is_crit: bool) -> void:
	AudioEventBus.raise_event_play_sfx(_hit_sfx)
	
	if is_crit:
		_create_crit_tween()

func _deal_damage_to_hp(info: DamageInfo) -> void:
	var damage: int = _resolve_damage_reduction_by_resistances(info)
	
	_current_hp = max(_current_hp - damage, 0)
	_update_hp_bar()

func _check_signal_emmisions(attacker: Node2D) -> void:
	if _current_hp == 0:
		destroyed.emit(attacker, _root)
	else:
		hit.emit()

func _create_crit_tween() -> void:
	var floating_label_instance: FloatingLabel = FLOATING_LABEL_SCENE.instantiate()
	add_child(floating_label_instance) # TODO: esto asume que si este Hurtbox muere se queda en escena unos segundos
	
	floating_label_instance.global_position = global_position
	floating_label_instance.show_message("CRIT!", Color.CRIMSON, 1.0)

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
