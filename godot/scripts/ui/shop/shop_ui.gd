extends Control
class_name ShopUI
"""
Contenedor de view y logica de comprar upgrades
"""

# Estilo DB
@export var _all_miner_upgrades: Array[UpgradeConfig]
@export var _all_warrior_upgrades: Array[UpgradeConfig]

@export_category("Dependencies")
@export var _miner_score: CollectableUI
@export var _warrior_score: CollectableUI
@export var _miner_upgrades_container: UpgradesContainerUI
@export var _warrior_upgrades_container: UpgradesContainerUI

signal exit_shop()


func _ready():
	_miner_score.initialize(Enums.WorldType.MINER)
	_warrior_score.initialize(Enums.WorldType.WARRIOR)
	
	_miner_upgrades_container.show_upgrades(_all_miner_upgrades)
	_warrior_upgrades_container.show_upgrades(_all_warrior_upgrades)

func _on_exit_shop_button_pressed():
	exit_shop.emit()








#
