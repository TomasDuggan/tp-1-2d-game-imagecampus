extends Control
class_name UpgradeUI
"""
Item que muestra la info de una upgrade
"""

@export_category("Dependencies")
@export var _icon: TextureRect
@export var _name: Label
@export var _level: Label
@export var _price: CollectableUI
@export var _buy_button: Button
@export var _description: Label

var _config: UpgradeConfig


func initialize(config: UpgradeConfig) -> void:
	_config = config

func _ready():
	_icon.texture = _config.icon
	_name.text = _config.display_name
	_level.text = "Level " + str(UpgradesManager.get_upgrade_level(_config))
	_description.text = _config.description
	calculate_price()
	
	_buy_button.pressed.connect(_buy_pressed)

func calculate_price() -> void:
	var price_text_color: Color = Color.LAWN_GREEN if _can_buy_upgrade() else Color.CRIMSON
	
	_price.initialize(_config.world_type, _config.price)
	_price.change_text_color(price_text_color)

func _can_buy_upgrade() -> bool:
	return CollectablesManager.can_buy(_config.world_type, _config.price)

func _buy_pressed() -> void:
	if _can_buy_upgrade():
		UpgradesEventBus.raise_event_upgrade_bought(_config)

func matches_config(config: UpgradeConfig) -> bool:
	return config == _config







#
