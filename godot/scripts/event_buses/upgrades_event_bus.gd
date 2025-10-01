extends Node
"""
Bus para eventos relacionados a Upgrades
"""

signal try_buy_upgrade(upgrade_config: UpgradeConfig, success: bool)


func raise_event_try_buy_upgrade(upgrade_config: UpgradeConfig, success: bool) -> void:
	try_buy_upgrade.emit(upgrade_config, success)
