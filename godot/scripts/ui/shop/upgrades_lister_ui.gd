extends ItemListerUI
class_name UpgradesListerUI
"""
Listador de upgrades
"""

@export_category("Config")
@export var _all_upgrades: Array[UpgradeConfig]


func _ready():
	UpgradesEventBus.upgrade_bought.connect(_on_upgrade_bought)

func create_items(view_mode: ItemUI.ViewMode) -> void:
	if view_mode == ItemUI.ViewMode.PURCHASE:
		_show_upgrades(UpgradesManager.filter_non_max_level(_all_upgrades), ItemUI.ViewMode.PURCHASE)
	if view_mode == ItemUI.ViewMode.INFORMATIVE:
		_show_upgrades(UpgradesManager.filter_owned(_all_upgrades), ItemUI.ViewMode.INFORMATIVE)

func _show_upgrades(upgrades: Array[UpgradeConfig], view_mode: ItemUI.ViewMode) -> void:
	for upgrade: UpgradeConfig in upgrades:
		create_item(upgrade, upgrade.basic_config, view_mode)

func _on_upgrade_bought(config: UpgradeConfig, success: bool) -> void:
	if !success:
		return
	
	_update_upgrade_ui(config)
	_update_all_upgrades_price_color()

func _update_upgrade_ui(config: UpgradeConfig) -> void:
	var bought_upgrade: ItemUI = _find_upgrade_ui(config)
	
	if bought_upgrade != null:
		if UpgradesManager.is_max_level(config):
			bought_upgrade.queue_free()
		else:
			bought_upgrade.update_dynamic_content()

func _find_upgrade_ui(config: UpgradeConfig) -> ItemUI:
	var filtered_upgrades: Array[ItemUI] = _get_upgrades().filter(func(u: ItemUI): return u.matches_config(config))
	return null if filtered_upgrades.is_empty() else filtered_upgrades.front()

func _update_all_upgrades_price_color() -> void:
	for upgrade: ItemUI in _get_upgrades():
		upgrade.resolve_price_color()

func _get_upgrades() -> Array[ItemUI]:
	var upgrades: Array[ItemUI] = []
	
	for c: ItemUI in get_children():
		upgrades.append(c)
		
	return upgrades

func _exit_tree():
	UpgradesEventBus.upgrade_bought.disconnect(_on_upgrade_bought)






#
