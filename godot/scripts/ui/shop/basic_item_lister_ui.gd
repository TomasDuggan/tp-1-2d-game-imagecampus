extends ItemListerUI
class_name BasicItemListerUI
"""
Listador de items con contenido basico
"""

@export_category("Config")
@export var _item_configs: Array[BasicItemConfig]

const BASIC_ITEM_UI_SCENE: PackedScene = preload("uid://cfltgh52i838t")


func create_items(_view_mode: ItemUI.ViewMode) -> void:
	for item_config: BasicItemConfig in _item_configs:
		create_item(null, item_config, ItemUI.ViewMode.BASIC)
