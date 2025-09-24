extends Control
class_name UpgradeUI
"""
Item que muestra la info de una upgrade
"""

@export_category("Editor Dependencies")
@export var _icon: TextureRect
@export var _name: Label
@export var _level: Label
@export var _buy_section: Container
@export var _price: CollectableUI
@export var _buy_button: Button
@export var _description: Label

enum ViewMode {
	INFORMATIVE, # Muestra el nivel actual y sin opciones de compra
	PURCHASE, # Muestra el nivel siguiente y habilita opciones de compra
}

var _config: UpgradeConfig
var _view_mode: ViewMode


func initialize(config: UpgradeConfig, view_mode: ViewMode) -> void:
	_config = config
	_view_mode = view_mode

func _ready() -> void:
	_icon.texture = _config.icon
	_name.text = _config.display_name
	
	_configure_dynamic_content()

func _configure_dynamic_content() -> void:
	var current_level: int = UpgradesManager.get_upgrade_level(_config)
	var display_level: int = _get_display_level(current_level)
	
	_level.text = _format_level_text(current_level, display_level)
	_description.text = _config.format_description(display_level)
	
	_configure_buy_section()

func _get_display_level(current_level: int) -> int:
	return current_level + 1 if _view_mode == ViewMode.PURCHASE else current_level

func _format_level_text(current_level: int, display_level: int) -> String:
	if current_level <= 0:
		return "Not owned"
	
	return "Level %d" % display_level

func _configure_buy_section() -> void:
	if _view_mode == ViewMode.INFORMATIVE:
		_buy_section.hide()
		return

	_price.initialize(_config.world_type, _config.price)
	resolve_price_color()
	
	_buy_button.pressed.connect(_buy_pressed)

func resolve_price_color() -> void:
	var price_text_color: Color = Color.GREEN_YELLOW if _can_buy_upgrade() else Color.CRIMSON
	_price.change_text_color(price_text_color)

func update_dynamic_content() -> void:
	_configure_dynamic_content()

func _can_buy_upgrade() -> bool:
	return CollectablesManager.can_buy(_config.world_type, _config.price)

func _buy_pressed() -> void:
	if _can_buy_upgrade():
		UpgradesEventBus.raise_event_upgrade_bought(_config)

func matches_config(config: UpgradeConfig) -> bool:
	return config == _config







#
