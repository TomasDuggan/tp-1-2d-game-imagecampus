extends Node
"""
Bus para eventos relacionados a Upgrades
"""

signal upgrade_bought(upgrade_config: UpgradeConfig, success: bool)


func raise_event_upgrade_bought(upgrade_config: UpgradeConfig, success: bool) -> void:
	upgrade_bought.emit(upgrade_config, success)
