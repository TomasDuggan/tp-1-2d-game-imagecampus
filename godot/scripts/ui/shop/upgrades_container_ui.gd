extends VBoxContainer
class_name UpgradesContainerUI
"""
Listador de upgrades de una categoria
"""

@export_category("Config")
@export var _all_upgrades: Array[UpgradeConfig]

const UPGRADE_UI_SCENE: PackedScene = preload("uid://c4xtc8qiymqhb")


func _ready():
	UpgradesEventBus.upgrade_bought.connect(_on_upgrade_bought)

func show_buyable_upgrades() -> void:
	_show_upgrades(UpgradesManager.filter_non_max_level(_all_upgrades), UpgradeUI.ViewMode.PURCHASE)

func show_owned_upgrades() -> void:
	_show_upgrades(UpgradesManager.filter_owned(_all_upgrades), UpgradeUI.ViewMode.INFORMATIVE)

func _show_upgrades(upgrades: Array[UpgradeConfig], view_mode: UpgradeUI.ViewMode) -> void:
	_clear_upgrades()
	
	for upgrade: UpgradeConfig in upgrades:
		_create_upgrade(upgrade, view_mode)

func _clear_upgrades() -> void:
	for upgrade: UpgradeUI in _get_upgrades():
		upgrade.queue_free()

func _create_upgrade(upgrade: UpgradeConfig, view_mode: UpgradeUI.ViewMode) -> void:
	var upgrade_instance: UpgradeUI = UPGRADE_UI_SCENE.instantiate()
	
	upgrade_instance.initialize(upgrade, view_mode)
	add_child(upgrade_instance)

func _on_upgrade_bought(config: UpgradeConfig) -> void:
	_update_upgrade_ui(config)
	_update_all_upgrades_price_color()

func _update_upgrade_ui(config: UpgradeConfig) -> void:
	var bought_upgrade: UpgradeUI = _find_upgrade_ui(config)
	
	if bought_upgrade != null:
		if UpgradesManager.is_max_level(config):
			bought_upgrade.queue_free()
		else:
			bought_upgrade.update_dynamic_content()

func _find_upgrade_ui(config: UpgradeConfig) -> UpgradeUI:
	var filtered_upgrades: Array[UpgradeUI] = _get_upgrades().filter(func(u: UpgradeUI): return u.matches_config(config))
	return null if filtered_upgrades.is_empty() else filtered_upgrades.front()

func _update_all_upgrades_price_color() -> void:
	for upgrade: UpgradeUI in _get_upgrades():
		upgrade.resolve_price_color()

func _get_upgrades() -> Array[UpgradeUI]:
	var upgrades: Array[UpgradeUI] = []
	
	for c: UpgradeUI in get_children():
		upgrades.append(c)
		
	return upgrades

func _exit_tree():
	UpgradesEventBus.upgrade_bought.disconnect(_on_upgrade_bought)






#
