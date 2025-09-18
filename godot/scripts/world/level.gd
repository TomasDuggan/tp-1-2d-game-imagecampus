extends Node
class_name Level
"""
Contenedor y coordinador entre Worlds
"""

@export var _miner_world: World
@export var _warrior_world: World
@export var _hero_selection_manager: HeroSelectionManager



func _ready():
	var miner_hero: Hero = _miner_world.get_hero()
	var warrior_hero: Hero = _warrior_world.get_hero()
	
	_miner_world.set_hero_ally(warrior_hero)
	_warrior_world.set_hero_ally(miner_hero)
	_hero_selection_manager.initialize([miner_hero, warrior_hero])






#
