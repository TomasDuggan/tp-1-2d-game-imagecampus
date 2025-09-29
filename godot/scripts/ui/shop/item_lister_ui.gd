@abstract
extends VBoxContainer
class_name ItemListerUI

const ITEM_UI_SCENE: PackedScene = preload("uid://c4xtc8qiymqhb")


func list_items(view_mode: ItemUI.ViewMode) -> void:
	_clean_items()
	create_items(view_mode)

func _clean_items() -> void:
	for c in get_children():
		c.queue_free()

@abstract
func create_items(view_mode: ItemUI.ViewMode) -> void

func create_item(upgrade_config: UpgradeConfig, basic_config: BasicItemConfig, view_mode: ItemUI.ViewMode) -> void:
	var item_instance: ItemUI = ITEM_UI_SCENE.instantiate()
	
	item_instance.initialize(upgrade_config, basic_config, view_mode)
	add_child(item_instance)
