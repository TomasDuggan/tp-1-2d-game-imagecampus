extends HBoxContainer
class_name CollectableUI
"""
UI para mostrar una cantidad de Collectables (icono + cantidad)
Lo uso tanto para el Score como para el Shop, por eso la vuelta de tuerca con "_fixed_amount"
* _fixed_amount != -1: Deja siempre fija la etiqueta del texto
"""

@onready var _collectable_icon: TextureRect = $CollectableIcon
@onready var _collectable_amount: Label = $CollectableAmount

var _world_type: World.WorldType
var _fixed_amount: int

const ICONS_BY_WORLD_TYPE: Dictionary[World.WorldType, Texture2D] = {
	World.WorldType.MINER: preload("uid://bm8eqm7pjupgf"),
	World.WorldType.WARRIOR: preload("uid://ccwrpax3qwusa"),
}


func initialize(world_type: World.WorldType, fixed_amount: int = -1) -> void:
	_world_type = world_type
	_fixed_amount = fixed_amount
	
	if !_use_fixed_amount():
		CollectableEventBus.collectable_amount_changed.connect(_on_collectables_changed)
	
	_initialize_icon_and_amount()

func _initialize_icon_and_amount() -> void:
	_collectable_icon.texture = ICONS_BY_WORLD_TYPE[_world_type]
	
	var collectables_amount: int = _fixed_amount if _use_fixed_amount() else CollectablesManager.get_current_amount(_world_type)
	_collectable_amount.text = str(collectables_amount)

func _use_fixed_amount() -> bool:
	return _fixed_amount != -1

func _on_collectables_changed(type: World.WorldType, current_amount: int) -> void:
	if type == _world_type:
		_collectable_amount.text = str(current_amount)

func change_text_color(color: Color) -> void:
	_collectable_amount.modulate = color

func _exit_tree():
	if !_use_fixed_amount():
		CollectableEventBus.collectable_amount_changed.disconnect(_on_collectables_changed)










#
