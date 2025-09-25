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
@export var _description: Label

enum ViewMode {
	INFORMATIVE, # Muestra el nivel actual y sin opciones de compra
	PURCHASE, # Muestra el nivel siguiente y habilita opciones de compra
}

const LEVEL_TEXT := "Level %d"
const MAX_LEVEL_TEXT_SUFFIX := " (Max)"

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
	return current_level if _view_mode == ViewMode.INFORMATIVE else current_level + 1

func _format_level_text(current_level: int, display_level: int) -> String:
	var shown_level := display_level if current_level > 0 else 1
	var level_text := LEVEL_TEXT % shown_level
	
	if UpgradesManager.is_max_level(_config):
		level_text += MAX_LEVEL_TEXT_SUFFIX
	
	return level_text

func _configure_buy_section() -> void:
	if _view_mode == ViewMode.INFORMATIVE:
		_buy_section.hide()
		return

	_price.initialize(_config.world_type, _config.price)
	resolve_price_color()

func resolve_price_color() -> void:
	var price_text_color: Color = Color.GREEN_YELLOW if _can_buy_upgrade() else Color.CRIMSON
	_price.change_text_color(price_text_color)

func update_dynamic_content() -> void:
	_configure_dynamic_content()

func _can_buy_upgrade() -> bool:
	return CollectablesManager.can_buy(_config.world_type, _config.price)

func _on_buy_button_pressed():
	if _can_buy_upgrade():
		UpgradesEventBus.raise_event_upgrade_bought(_config)

func matches_config(config: UpgradeConfig) -> bool:
	return config == _config







#
