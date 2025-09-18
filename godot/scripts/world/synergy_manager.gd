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

const SYNERGY_EFFECT_DURATION := 10.0
const SYNERGY_DECAY_DELAY := 5.0
const SYNERGY_DECAY_VALUE := -0.1

const SWAP_SYNERGY_INCREASE_VALUE := 0.1
const COLLECTABLE_GAINED_SYNERGY_INCREASE_VALUE := 0.1


func _ready():
	_synergy_effect_timer.one_shot = true
	_synergy_effect_timer.wait_time = SYNERGY_EFFECT_DURATION
	_synergy_effect_timer.timeout.connect(_synergy_effect_ended)
	add_child(_synergy_effect_timer)
	
	_synergy_decay_timer.autostart = true
	_synergy_decay_timer.wait_time = SYNERGY_DECAY_DELAY
	_synergy_decay_timer.timeout.connect(func(): _update_synergy_value(SYNERGY_DECAY_VALUE))
	add_child(_synergy_decay_timer)
	
	HeroEventBus.hero_swapped.connect(_on_hero_swapped)
	CollectableEventBus.collectable_amount_changed.connect(_on_collectable_gained)

func _on_hero_swapped():
	_update_synergy_value(SWAP_SYNERGY_INCREASE_VALUE)

func _on_collectable_gained(_type, _amount) -> void:
	_update_synergy_value(COLLECTABLE_GAINED_SYNERGY_INCREASE_VALUE)

func _update_synergy_value(value: float) -> void:
	if !_synergy_effect_timer.is_stopped():
		return
	
	_current_synergy = clamp(_current_synergy + value, 0.0, 1.0)
	
	_create_slide_bar_tween(0.1)

	if _current_synergy == 1.0:
		_activate_synergy_effect()

func _create_slide_bar_tween(duration: float) -> void:
	if _current_slidebar_tween:
		_current_slidebar_tween.kill()
	
	_current_slidebar_tween = create_tween()
	_current_slidebar_tween.tween_property(_synergy_bar, "value", _current_synergy, duration)

func _activate_synergy_effect() -> void:
	_synergy_decay_timer.stop()
	_synergy_effect_timer.start()
	
	_current_synergy = 0.0
	_create_slide_bar_tween(SYNERGY_EFFECT_DURATION)
	
	SynergyEventBus.raise_event_synergy_effect_activated()

func _synergy_effect_ended() -> void:
	_synergy_decay_timer.start()
	SynergyEventBus.raise_event_synergy_effect_ended()

func _exit_tree():
	HeroEventBus.hero_swapped.disconnect(_on_hero_swapped)
	CollectableEventBus.collectable_amount_changed.disconnect(_on_collectable_gained)
