extends Control
class_name ItemUI
"""
Item que muestra info en la UI
"""

@export_category("Editor Dependencies")
@export var _icon: TextureRect
@export var _name: Label
@export var _level: Label
@export var _buy_section: Container
@export var _price: CollectableUI
@export var _description: Label

enum ViewMode {
	BASIC, # Muestra solo la info basica
	INFORMATIVE, # Muestra el nivel actual y sin opciones de compra
	PURCHASE, # Muestra el nivel siguiente y habilita opciones de compra
}

const LEVEL_TEXT := "Level %d"
const MAX_LEVEL_TEXT_SUFFIX := " (Max)"

var _upgrade_config: UpgradeConfig
var _basic_config: BasicItemConfig
var _view_mode: ViewMode


func initialize(upgrade_config: UpgradeConfig, basic_config: BasicItemConfig, view_mode: ViewMode) -> void:
	_upgrade_config = upgrade_config
	_basic_config = basic_config
	_view_mode = view_mode

func _ready() -> void:
	_icon.texture = _basic_config.icon
	_name.text = _basic_config.display_name
	
	if _view_mode == ViewMode.BASIC:
		_description.text = _basic_config.description
		_level.hide()
		_buy_section.hide()
		return
	
	_configure_dynamic_content()

func _configure_dynamic_content() -> void:
	var current_level: int = UpgradesManager.get_upgrade_level(_upgrade_config)
	var display_level: int = _get_display_level(current_level)
	
	_level.text = _format_level_text(current_level, display_level)
	_description.text = _upgrade_config.format_description(display_level)
	
	_configure_buy_section()

func _get_display_level(current_level: int) -> int:
	return current_level if _view_mode == ViewMode.INFORMATIVE else current_level + 1

func _format_level_text(current_level: int, display_level: int) -> String:
	var shown_level: int = display_level if current_level > 0 else 1
	var level_text: String = LEVEL_TEXT % shown_level
	
	if UpgradesManager.is_max_level(_upgrade_config):
		level_text += MAX_LEVEL_TEXT_SUFFIX
	
	return level_text

func _configure_buy_section() -> void:
	if _view_mode == ViewMode.INFORMATIVE:
		_buy_section.hide()
		return

	_price.initialize(_upgrade_config.world_type, _upgrade_config.price)
	resolve_price_color()

func resolve_price_color() -> void:
	var price_text_color: Color = Color.GREEN_YELLOW if _can_buy_upgrade() else Color.CRIMSON
	_price.change_text_color(price_text_color)

func update_dynamic_content() -> void:
	_configure_dynamic_content()

func _can_buy_upgrade() -> bool:
	return CollectablesManager.can_buy(_upgrade_config.world_type, _upgrade_config.price)

func _on_buy_button_pressed():
	if _can_buy_upgrade():
		UpgradesEventBus.raise_event_upgrade_bought(_upgrade_config)

func matches_config(config: UpgradeConfig) -> bool:
	return config == _upgrade_config







#
