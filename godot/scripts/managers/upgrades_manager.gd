extends Node
"""
Global para almacenar y hacer query sobre las upgrades compradas
"""

var _bought_upgrades: Array[UpgradeConfig] = []


#TODO: borrar esto, es mock
func _ready():
	_bought_upgrades.append(preload("uid://4iq72jx00k26"))
	_bought_upgrades.append(preload("uid://dqsgdu0754klx"))
	
	var upgrade_names: Array = _bought_upgrades.map(func(u: UpgradeConfig): return u.display_name)
	print("Agregando upgrades mock: ", upgrade_names)

func add_upgrade(upgrade: UpgradeConfig) -> void:
	_bought_upgrades.append(upgrade)

func get_modifier_value(world_type: Enums.WorldType, upgrade_id: Enums.UpgradeId) -> float:
	for upgrade: UpgradeConfig in _bought_upgrades:
		if upgrade.world_type == world_type && upgrade.id == upgrade_id:
			return upgrade.stat_modifier_value
	
	return 0.0
