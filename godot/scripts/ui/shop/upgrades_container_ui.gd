extends VBoxContainer
class_name UpgradesContainerUI
"""
Listador de upgrades
"""

@export_category("Config")
@export var _all_upgrades: Array[UpgradeConfig]

const UPGRADE_UI_SCENE: PackedScene = preload("uid://c4xtc8qiymqhb")


func _ready():
	UpgradesEventBus.upgrade_bought.connect(_on_upgrade_bought)


func show_buyable_upgrades() -> void:
	_clear_upgrades()
	
	for upgrade: UpgradeConfig in _all_upgrades:
		_create_upgrade(upgrade, true)

func show_owned_upgrades() -> void:
	_clear_upgrades()
	
	for upgrade: UpgradeConfig in UpgradesManager.filter_owned(_all_upgrades):
		_create_upgrade(upgrade, false)

func _clear_upgrades() -> void:
	for upgrade: UpgradeUI in _get_upgrades():
		upgrade.queue_free()

func _create_upgrade(upgrade: UpgradeConfig, show_buy_section: bool) -> void:
	var upgrade_instance: UpgradeUI = UPGRADE_UI_SCENE.instantiate()
	
	upgrade_instance.initialize(upgrade, show_buy_section)
	add_child(upgrade_instance)

func _on_upgrade_bought(config: UpgradeConfig) -> void:
	_remove_upgrade(config)
	_update_upgrades_price_color()

func _remove_upgrade(config: UpgradeConfig) -> void:
	var bought_upgrade: UpgradeUI = _find_upgrade_ui(config)
	
	if bought_upgrade != null:
		bought_upgrade.queue_free()

func _find_upgrade_ui(config: UpgradeConfig) -> UpgradeUI:
	var filtered_upgrades: Array[UpgradeUI] = _get_upgrades().filter(func(u: UpgradeUI): return u.matches_config(config))
	return null if filtered_upgrades.is_empty() else filtered_upgrades.front()

func _update_upgrades_price_color() -> void:
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
