extends Node
"""
Global para almacenar y hacer query sobre las upgrades compradas
"""

var _bought_upgrades: Array[Upgrade] = []



func _ready():
	UpgradesEventBus.upgrade_bought.connect(_add_upgrade)
	
	#TODO: borrar esto, es mock testing
	#_add_upgrade(preload("uid://4iq72jx00k26")) # + DMG
	#_add_upgrade(preload("uid://4iq72jx00k26")) # + DMG lvl 2 (agrego dos veces la misma config, levelea)
	#_add_upgrade(preload("uid://dqsgdu0754klx")) # + horizontal speed

#TODO: borrar esto, es para testing
func print_current_bought_upgrades():
	var upgrade_names: Array = _bought_upgrades.map(func(u: Upgrade): return u._config.display_name)
	print_debug("Upgrades compradas: ", upgrade_names)

func _add_upgrade(new_upgrade_config: UpgradeConfig) -> void:
	var found_upgrade: Upgrade = _find_upgrade_by_config(new_upgrade_config)
	
	if found_upgrade == null:
		var new_upgrade := Upgrade.new(new_upgrade_config)
		_bought_upgrades.append(new_upgrade)
	else:
		found_upgrade.level_up()

func _find_upgrade_by_config(upgrade: UpgradeConfig) -> Upgrade:
	var filtered: Array[Upgrade] = _bought_upgrades.filter(func(u: Upgrade): return u.get_config() == upgrade)
	return null if filtered.is_empty() else filtered.front()

func get_upgrade_level(config: UpgradeConfig) -> int:
	var found_upgrade: Upgrade = _find_upgrade_by_config(config)
	return 0 if found_upgrade == null else found_upgrade.get_current_level()

func get_modifier_value(world_type: Enums.WorldType, upgrade_id: Enums.UpgradeId) -> float:
	var upgrade: Upgrade = _find_upgrade_by_context(world_type, upgrade_id)
	return 0.0 if upgrade == null else upgrade.get_value()

func _find_upgrade_by_context(world_type: Enums.WorldType, upgrade_id: Enums.UpgradeId) -> Upgrade:
	var filtered: Array[Upgrade] = _bought_upgrades.filter(func(u: Upgrade): return u.matches(world_type, upgrade_id))
	return null if filtered.is_empty() else filtered.front()

func _exit_tree():
	UpgradesEventBus.upgrade_bought.disconnect(_add_upgrade)







#
