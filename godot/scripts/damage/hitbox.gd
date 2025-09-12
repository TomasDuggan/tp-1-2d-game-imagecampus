extends Area2D
class_name Hitbox
"""
Escena para hacer dmg a Hurtbox
"""


signal attack_performed()
signal target_destroyed(defender_root: Node2D)

var _damage_source: Node2D
var _attack_cd_timer := Timer.new()
var _damage: int
var _targets_in_range: Array[Hurtbox] = []
var _source_faction: Enums.DamageFaction

# TODO: logica de "autoattack == false"
func initialize(damage_source: Node2D, damage: int, attack_speed: float, autoattack: bool, source_faction: Enums.DamageFaction) -> void:
	_damage_source = damage_source
	_damage = damage
	_source_faction = source_faction
	
	_attack_cd_timer.autostart = autoattack
	_attack_cd_timer.wait_time = attack_speed
	_attack_cd_timer.timeout.connect(_on_attack_timeout)
	add_child(_attack_cd_timer)

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(target: Hurtbox) -> void:
	if target.is_ally(_source_faction):
		return
	
	_targets_in_range.append(target)
	target.destroyed.connect(_on_target_destroyed)

func _on_area_exited(target: Hurtbox) -> void:
	if target.is_ally(_source_faction):
		return
	
	_targets_in_range.erase(target)
	target.destroyed.disconnect(_on_target_destroyed)

func _on_target_destroyed(_attacker: Node2D, defender: Node2D) -> void:
	target_destroyed.emit(defender)

func _on_attack_timeout() -> void:
	attack_performed.emit()
	
	for target: Hurtbox in _targets_in_range:
		target.receive_damage(_damage_source, _damage)

func toggle_detection() -> void:
	set_deferred("monitoring", !monitoring)








#
