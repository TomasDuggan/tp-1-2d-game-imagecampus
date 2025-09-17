extends Node
class_name Level
"""
Contenedor y coordinador entre Worlds
"""


@export var _miner_world: World
@export var _warrior_world: World


func _ready():
	_miner_world.set_hero_ally(_warrior_world.get_hero())
	_warrior_world.set_hero_ally(_miner_world.get_hero())
