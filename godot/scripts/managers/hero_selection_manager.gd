extends Node
class_name HeroSelectionManager
"""
Manager de la logica de seleccion de un Heroe para controlarlo
"""

var _heroes: Array[Hero]
var _block_swap_timer := Timer.new()
var _synergy_effect_activated: bool

const SWAP_HERO_ACTION_NAME := "swap_hero"


func initialize(heroes: Array[Hero]) -> void:
	_heroes = heroes
	_select_only_first_hero()

func _select_only_first_hero() -> void:
	var start_selected_hero: Hero = _heroes.front()
	start_selected_hero.select()
	
	for hero: Hero in _heroes.filter(func(h: Hero): return h != start_selected_hero):
		hero.deselect()

func _ready():
	_block_swap_timer.one_shot = true
	add_child(_block_swap_timer)
	
	HeroEventBus.block_hero_swap.connect(_block_swap)
	SynergyEventBus.synergy_effect_activated.connect(_on_synergy_effect_activated)
	SynergyEventBus.synergy_effect_ended.connect(_on_synergy_effect_ended)

func _unhandled_key_input(event: InputEvent):
	if event.is_action_pressed(SWAP_HERO_ACTION_NAME):
		_swap_hero_selection()

func _can_swap() -> bool:
	return _block_swap_timer.is_stopped() && !_synergy_effect_activated

func _find_selected_hero() -> Hero:
	return _heroes.filter(func(h: Hero): return h.is_selected()).front()

func _find_unselected_hero() -> Hero:
	return _heroes.filter(func(h: Hero): return !h.is_selected()).front()

func _swap_hero_selection() -> void:
	var selected: Hero = _find_selected_hero()
	var unselected: Hero = _find_unselected_hero()
	var can_swap: bool = _can_swap()
	
	if can_swap:
		selected.deselect()
		unselected.select()
	
	HeroEventBus.raise_event_swap_hero(selected, unselected, can_swap)

func _on_synergy_effect_activated() -> void:
	_synergy_effect_activated = true
	for hero: Hero in _heroes:
		hero.select()

func _on_synergy_effect_ended() -> void:
	_synergy_effect_activated = false
	_select_only_first_hero()

func _block_swap(block_duration: float) -> void:
	_block_swap_timer.start(block_duration)

func _exit_tree():
	HeroEventBus.block_hero_swap.disconnect(_block_swap)
	SynergyEventBus.synergy_effect_activated.disconnect(_on_synergy_effect_activated)
	SynergyEventBus.synergy_effect_ended.disconnect(_on_synergy_effect_ended)








#
