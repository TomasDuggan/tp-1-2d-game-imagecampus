extends Node
class_name Level
"""
Contenedor y coordinador entre Worlds
"""

@export_category("Editor Dependencies")
@export var _miner_world: World
@export var _warrior_world: World
@export var _hero_selection_manager: HeroSelectionManager
@export var _level_won_menu: Control

signal level_won()

var _hero_won_world_counter := 0


func _ready():
	UpgradesManager.print_current_bought_upgrades()
	
	_level_won_menu.hide()
	
	var miner_hero: Hero = _miner_world.get_hero()
	var warrior_hero: Hero = _warrior_world.get_hero()
	
	_miner_world.set_ally_hero(warrior_hero)
	_warrior_world.set_ally_hero(miner_hero)
	_hero_selection_manager.initialize([miner_hero, warrior_hero])
	
	HeroEventBus.hero_won_world.connect(_on_hero_won_world)

func _on_hero_won_world(_hero: Hero) -> void:
	_hero_won_world_counter += 1
	
	if _hero_won_world_counter == 2:
		get_tree().paused = true
		_level_won_menu.show()

func _on_go_to_shop_button_pressed():
	get_tree().paused = false
	level_won.emit()

func _exit_tree():
	HeroEventBus.hero_won_world.disconnect(_on_hero_won_world)




#
