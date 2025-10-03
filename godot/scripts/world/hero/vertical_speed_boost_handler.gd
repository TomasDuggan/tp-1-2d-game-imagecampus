extends Node
class_name VerticalSpeedBoostHandler
"""
Manejador del boost que recibe el heroe para avanzar en el eje Y.
"""

signal vertical_speed_changed(new_vertical_speed: float)

var _vertical_speed_boost_timer := Timer.new()
var _boost_duration_modifier: float
var _boost_particles: CPUParticles2D

const USUAL_VERTICAL_SPEED := 0.0
const VERTICAL_SPEED_BOOST := -100
const SYNERGY_BOOST_DURATION := 1.0
const SPEED_BOOST_UPGRADE_CONFIG: UpgradeConfig = preload("uid://8uf7i4twtmc4")


func initialize(boost_particles: CPUParticles2D) -> void:
	_boost_particles = boost_particles
	_boost_particles.show()
	_boost_particles.emitting = false

func _ready():
	SynergyEventBus.synergy_effect_activated.connect(_on_synergy_activated)
	
	_boost_duration_modifier = UpgradesManager.get_modifier_value(
		SPEED_BOOST_UPGRADE_CONFIG.world_type as World.WorldType,
		SPEED_BOOST_UPGRADE_CONFIG.id as UpgradesManager.UpgradeId
	)
	_vertical_speed_boost_timer.one_shot = true
	add_child(_vertical_speed_boost_timer)

func _on_synergy_activated() -> void:
	_apply_boost(SYNERGY_BOOST_DURATION)

func on_target_destroyed(collectable: Collectable) -> void:
	var boost_duration: float = collectable.get_destroyed_velocity_boost_duration()
	if boost_duration <= 0:
		return
	
	_apply_boost(boost_duration)

func _apply_boost(boost_duration: float) -> void:
	if _vertical_speed_boost_timer.is_stopped():
		_boost_particles.emitting = true
		_vertical_speed_boost_timer.timeout.connect(_on_speed_boost_expired, CONNECT_ONE_SHOT)
	
	_vertical_speed_boost_timer.start(_get_boost_duration(boost_duration))
	
	vertical_speed_changed.emit(VERTICAL_SPEED_BOOST)

func _get_boost_duration(collectable_boost_duration: float) -> float:
	return collectable_boost_duration + collectable_boost_duration * _boost_duration_modifier

func _on_speed_boost_expired() -> void:
	_boost_particles.emitting = false
	vertical_speed_changed.emit(USUAL_VERTICAL_SPEED)

func _exit_tree():
	SynergyEventBus.synergy_effect_activated.disconnect(_on_synergy_activated)









#
