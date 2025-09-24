extends Control
class_name ShopUI
"""
Contenedor de view y logica de comprar upgrades
"""

@export_category("Dependencies")
@export var _miner_score: CollectableUI
@export var _warrior_score: CollectableUI
@export var _upgrade_containers: Array[UpgradesContainerUI]

signal exit_shop()


func _ready():
	_miner_score.initialize(Enums.WorldType.MINER)
	_warrior_score.initialize(Enums.WorldType.WARRIOR)
	
	_on_show_buyable_upgrades_pressed()

func _on_show_buyable_upgrades_pressed():
	for upgrade_container: UpgradesContainerUI in _upgrade_containers:
		upgrade_container.show_buyable_upgrades()

func _on_show_owned_upgrades_pressed():
	for upgrade_container: UpgradesContainerUI in _upgrade_containers:
		upgrade_container.show_owned_upgrades()

func _on_exit_shop_button_pressed():
	exit_shop.emit()








#
