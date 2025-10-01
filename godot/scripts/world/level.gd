extends Node
class_name Level
"""
Contenedor y coordinador entre Worlds
"""

 # TODO, parametrizar o mandarlo a una DB
@export_category("Config")
@export var _miner_config: HeroConfig
@export var _warrior_config: HeroConfig
@export var _music: Array[AudioStream]

@export_category("Editor Dependencies")
@export var _miner_world: World
@export var _warrior_world: World
@export var _hero_selection_manager: HeroSelectionManager

signal go_to_shop()


func _ready():
	UpgradesManager.print_current_bought_upgrades() # TODO: borrar
	AudioEventBus.raise_event_play_music(_music.pick_random())
	
	var miner_hero: Hero = _miner_world.get_hero()
	var warrior_hero: Hero = _warrior_world.get_hero()
	
	_initialize_worlds(miner_hero, warrior_hero)
	
	_hero_selection_manager.initialize([miner_hero, warrior_hero])

func _initialize_worlds(miner_hero: Hero, warrior_hero: Hero) -> void:
	_miner_world.initialize(
		World.WorldType.MINER,
		_miner_config,
		warrior_hero
	)
	_warrior_world.initialize(
		World.WorldType.WARRIOR,
		_warrior_config,
		miner_hero
	)
	
	_miner_world.interactable_room_spawned.connect(_warrior_world.spawn_interactable_room)

func _on_go_to_shop_button_pressed():
	get_tree().paused = false
	go_to_shop.emit()


#
