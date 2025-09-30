extends ItemListerUI
class_name BasicItemListerUI
"""
Listador de items con contenido basico
"""

@export_category("Config")
@export var _item_configs: Array[BasicItemConfig]


func create_items(_view_mode: ItemUI.ViewMode) -> void:
	for item_config: BasicItemConfig in _item_configs:
		create_item(null, item_config, ItemUI.ViewMode.BASIC)
