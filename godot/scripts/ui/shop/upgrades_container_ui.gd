extends VBoxContainer
class_name UpgradesContainerUI

const UPGRADE_SCENE: PackedScene = preload("uid://c4xtc8qiymqhb")


func show_upgrades(upgrades: Array[UpgradeConfig]) -> void:
	for upgrade: UpgradeConfig in upgrades:
		var upgrade_instance: UpgradeUI = UPGRADE_SCENE.instantiate()
		upgrade_instance.initialize(upgrade)
		add_child(upgrade_instance)
