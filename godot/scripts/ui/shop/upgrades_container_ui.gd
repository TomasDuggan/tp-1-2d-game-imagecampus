extends VBoxContainer
class_name UpgradesContainerUI
"""
Listador de upgrades
"""

const UPGRADE_SCENE: PackedScene = preload("uid://c4xtc8qiymqhb")

var _upgrades: Array[UpgradeUI] = []

func _ready():
	UpgradesEventBus.upgrade_bought.connect(_on_upgrade_bought)

func show_upgrades(upgrades: Array[UpgradeConfig]) -> void:
	for upgrade: UpgradeConfig in upgrades:
		var upgrade_instance: UpgradeUI = UPGRADE_SCENE.instantiate()
		
		upgrade_instance.initialize(upgrade)
		_upgrades.append(upgrade_instance)
		add_child(upgrade_instance)

func _on_upgrade_bought(config: UpgradeConfig) -> void:
	var bought_upgrade: UpgradeUI = _find_upgrade_ui(config)
	
	if bought_upgrade != null:
		_upgrades.erase(bought_upgrade)
		bought_upgrade.queue_free()
		
		for upgrade: UpgradeUI in _upgrades:
			upgrade.calculate_price()

func _find_upgrade_ui(config: UpgradeConfig) -> UpgradeUI:
	var filtered_upgrades: Array[UpgradeUI] = _upgrades.filter(func(u: UpgradeUI): return u.matches_config(config))
	return null if filtered_upgrades.is_empty() else filtered_upgrades.front()

func _exit_tree():
	UpgradesEventBus.upgrade_bought.disconnect(_on_upgrade_bought)






#
