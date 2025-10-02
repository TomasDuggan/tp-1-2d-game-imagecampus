extends Node
"""
Global para almacenar y hacer query sobre las upgrades compradas.
Las upgrades afectan valores basicos (numericos) del gameplay.
	Aunque tambien podrian usarse como flags para hacer cosas mas locas
"""

var _bought_upgrades: Array[Upgrade] = []

# UpgradeId + World.WorldType para afectar a un Hero puntual
# UpgradeId y usar la instancia del resource para afectar globalmente
enum UpgradeId {
	DAMAGE,
	HP,
	HORIZONTAL_MOVEMENT_SPEED,
	CURRENCY_GATHER,
	FIRE_DAMAGE_REDUCTION,
	SYNERGY_GAIN,
	SPEED_BOOST,
}

func _ready():
	UpgradesEventBus.try_buy_upgrade.connect(_add_upgrade)

#TODO: borrar esto, es para testing
func print_current_bought_upgrades():
	var upgrade_names: Array = _bought_upgrades.map(func(u: Upgrade): return u._config.basic_config.display_name + " (lvl " + str(u.get_current_level()) + ")")
	print_debug("Upgrades compradas: ", upgrade_names)

func _add_upgrade(new_upgrade_config: UpgradeConfig, success: bool) -> void:
	if !success:
		return
	
	var found_upgrade: Upgrade = _find_upgrade_by_config(new_upgrade_config)
	
	if found_upgrade == null:
		var new_upgrade := Upgrade.new(new_upgrade_config)
		_bought_upgrades.append(new_upgrade)
	else:
		found_upgrade.level_up()

func _find_upgrade_by_config(upgrade: UpgradeConfig) -> Upgrade:
	var filtered: Array[Upgrade] = _bought_upgrades.filter(func(u: Upgrade): return u.matches_config(upgrade))
	return null if filtered.is_empty() else filtered.front()

func get_upgrade_level(config: UpgradeConfig) -> int:
	var found_upgrade: Upgrade = _find_upgrade_by_config(config)
	return 0 if found_upgrade == null else found_upgrade.get_current_level()

func get_modifier_value(world_type: World.WorldType, upgrade_id: UpgradeId) -> float:
	var upgrade: Upgrade = _find_upgrade_by_context(world_type, upgrade_id)
	return 0.0 if upgrade == null else upgrade.get_value()

func filter_owned(upgrades: Array[UpgradeConfig]) -> Array[UpgradeConfig]:
	var filtered: Array[UpgradeConfig] = []
	
	for upgrade: Upgrade in _bought_upgrades:
		if upgrade.get_config() in upgrades:
			filtered.append(upgrade.get_config())
	
	return filtered

func filter_non_max_level(upgrades: Array[UpgradeConfig]) -> Array[UpgradeConfig]:
	var filtered: Array[UpgradeConfig] = []
	
	for upgrade_config: UpgradeConfig in upgrades:
		if !is_max_level(upgrade_config):
			filtered.append(upgrade_config)
	
	return filtered

func is_max_level(upgrade_config: UpgradeConfig) -> bool:
	var upgrade: Upgrade = _find_upgrade_by_config(upgrade_config)
	return upgrade != null && upgrade.is_max_level()

func _find_upgrade_by_context(world_type: World.WorldType, upgrade_id: UpgradeId) -> Upgrade:
	var filtered: Array[Upgrade] = _bought_upgrades.filter(func(u: Upgrade): return u.matches(world_type, upgrade_id))
	return null if filtered.is_empty() else filtered.front()

func _exit_tree():
	UpgradesEventBus.try_buy_upgrade.disconnect(_add_upgrade)







#
