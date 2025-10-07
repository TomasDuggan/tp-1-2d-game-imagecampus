extends Control
class_name ShopUI
"""
Contenedor de view y logica de comprar o ver upgrades, listar los collectables, etc.
"""

@export_category("Config")
@export var _music: AudioStream

@export_category("Editor Dependencies")
@export var _miner_score: CollectableUI
@export var _warrior_score: CollectableUI
@export var _upgrades_container: Container
@export var _bestiary_container: Container

const SETTINGS_SCENE: PackedScene = preload("uid://bmwvgt0131dh6")

var _upgrade_listers: Array[ItemListerUI]
var _bestiary_listers: Array[ItemListerUI]


func _ready():
	AudioEventBus.raise_event_play_music(_music)
	
	_miner_score.initialize(World.WorldType.MINER)
	_warrior_score.initialize(World.WorldType.WARRIOR)
	
	_upgrade_listers = _find_item_listers_in_container(_upgrades_container)
	_bestiary_listers = _find_item_listers_in_container(_bestiary_container)
	
	_on_show_buyable_upgrades_pressed()

func _find_item_listers_in_container(container: Container) -> Array[ItemListerUI]:
	var listers: Array[ItemListerUI] = []
	
	for c in container.find_children("*", "ItemListerUI"):
		if c is ItemListerUI:
			listers.append(c)
	
	return listers

func _on_show_buyable_upgrades_pressed():
	_show_items(true, _upgrade_listers, ItemUI.ViewMode.PURCHASE)

func _on_show_owned_upgrades_pressed():
	_show_items(true, _upgrade_listers, ItemUI.ViewMode.INFORMATIVE)

func _on_show_bestiary_pressed():
	_show_items(false, _bestiary_listers, ItemUI.ViewMode.BASIC)

func _show_items(show_upgrades: bool, listers: Array[ItemListerUI], view_mode: ItemUI.ViewMode) -> void:
	_upgrades_container.set_visible(show_upgrades)
	_bestiary_container.set_visible(!show_upgrades)
	
	for upgrade_lister: ItemListerUI in listers:
		upgrade_lister.list_items(view_mode)

func _on_exit_shop_button_pressed():
	SceneLoadManager.load_level()

func _on_settings_button_pressed():
	var pause_menu: OptionsMenuUI = SETTINGS_SCENE.instantiate()
	pause_menu.initialize(OptionsMenuUI.MenuMode.SHOP)
	pause_menu.resume.connect(func(): pause_menu.queue_free())
	add_child(pause_menu)







#
