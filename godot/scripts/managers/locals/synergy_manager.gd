extends Node
class_name SynergyManager
"""
Manager de la mecanica Sinergia.
"""

@export var _synergy_bar: TextureProgressBar

var _current_synergy: float
var _synergy_effect_timer := Timer.new()
var _synergy_decay_timer := Timer.new()
var _current_slidebar_tween: Tween
var _synergy_gain_upgrade_multiplier: float

const MAX_SYNERGY_AMOUNT := 1.0
const MIN_SYNERGY_AMOUNT := 0.0
const SYNERGY_EFFECT_DURATION := 10.0
const SYNERGY_DECAY_DELAY := 5.0
const SYNERGY_DECAY_VALUE := -0.1

const SWAP_SYNERGY_INCREASE_VALUE := 0.03
const COLLECTABLE_GAINED_SYNERGY_INCREASE_VALUE := 0.05
const INTERACTABLE_PRESSED_SYNERGY_INCREASE_VALUE := 0.15


func _ready():
	LevelEventBus.level_won.connect(_on_level_ended)
	LevelEventBus.level_lost.connect(_on_level_ended)
	
	_synergy_effect_timer.one_shot = true
	_synergy_effect_timer.wait_time = SYNERGY_EFFECT_DURATION
	_synergy_effect_timer.timeout.connect(_synergy_effect_ended)
	add_child(_synergy_effect_timer)
	
	_synergy_decay_timer.autostart = true
	_synergy_decay_timer.wait_time = SYNERGY_DECAY_DELAY
	_synergy_decay_timer.timeout.connect(func(): _update_synergy_value(SYNERGY_DECAY_VALUE))
	add_child(_synergy_decay_timer)
	
	_synergy_gain_upgrade_multiplier = _resolve_synergy_gain_upgrade_multiplier()
	
	# No conecto con lambda para poder desconectarme bien en _exit_tree
	SynergyEventBus.gain_synergy.connect(_on_gain_synergy)
	HeroEventBus.hero_swapped.connect(_on_hero_swapped)
	CollectableEventBus.collectable_amount_changed.connect(_on_collectable_gained)
	InteractablesManager.interactable_pressed.connect(_on_interactable_pressed)

func _resolve_synergy_gain_upgrade_multiplier() -> float:
	const SYNERGY_GAIN_UPGRADE_CONFIG: UpgradeConfig = preload("uid://drg1frcy4axsl")
	
	return UpgradesManager.get_modifier_value(
		SYNERGY_GAIN_UPGRADE_CONFIG.world_type as World.WorldType,
		SYNERGY_GAIN_UPGRADE_CONFIG.id as UpgradesManager.UpgradeId,
	)

func _on_gain_synergy(normalized_value: float) -> void:
	_update_synergy_value(normalized_value)

func _on_hero_swapped(_from, _to, success: bool):
	if success:
		_update_synergy_value(SWAP_SYNERGY_INCREASE_VALUE)

func _on_collectable_gained(_type, _amount) -> void:
	_update_synergy_value(COLLECTABLE_GAINED_SYNERGY_INCREASE_VALUE)

func _on_interactable_pressed(_id) -> void:
	_update_synergy_value(INTERACTABLE_PRESSED_SYNERGY_INCREASE_VALUE)

func _update_synergy_value(value: float) -> void:
	if _is_synergy_effect_active():
		return
	
	# Solo aplicar upgrade si es positivo
	if value > 0:
		value += value * _synergy_gain_upgrade_multiplier
	
	_current_synergy = clamp(_current_synergy + value, MIN_SYNERGY_AMOUNT, MAX_SYNERGY_AMOUNT)
	
	_create_slide_bar_tween(0.1)
	
	if _current_synergy == MAX_SYNERGY_AMOUNT:
		_synergy_bar.value = MAX_SYNERGY_AMOUNT
		_activate_synergy_effect()

func _is_synergy_effect_active() -> bool:
	return !_synergy_effect_timer.is_stopped()

func _create_slide_bar_tween(duration: float) -> void:
	if _current_slidebar_tween:
		_current_slidebar_tween.kill()
	
	_current_slidebar_tween = create_tween()
	_current_slidebar_tween.tween_property(_synergy_bar, "value", _current_synergy, duration)

func _activate_synergy_effect() -> void:
	_synergy_decay_timer.stop()
	_synergy_effect_timer.start()
	
	_current_synergy = MIN_SYNERGY_AMOUNT
	_create_slide_bar_tween(SYNERGY_EFFECT_DURATION)
	
	SynergyEventBus.raise_event_synergy_effect_activated()

func _synergy_effect_ended() -> void:
	_synergy_decay_timer.start()
	SynergyEventBus.raise_event_synergy_effect_ended()

func _on_level_ended() -> void:
	_synergy_bar.hide()

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_ended)
	LevelEventBus.level_lost.disconnect(_on_level_ended)
	
	SynergyEventBus.gain_synergy.disconnect(_on_gain_synergy)
	HeroEventBus.hero_swapped.disconnect(_on_hero_swapped)
	CollectableEventBus.collectable_amount_changed.disconnect(_on_collectable_gained)
	InteractablesManager.interactable_pressed.disconnect(_on_interactable_pressed)
