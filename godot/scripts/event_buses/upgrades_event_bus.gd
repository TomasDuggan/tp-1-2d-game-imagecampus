extends Node
"""
Bus para eventos relacionados a Upgrades
"""

signal upgrade_bought(upgrade_config: UpgradeConfig)

func raise_event_upgrade_bought(upgrade_config: UpgradeConfig) -> void:
	upgrade_bought.emit(upgrade_config)
