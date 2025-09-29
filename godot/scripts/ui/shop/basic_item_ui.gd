extends Control
class_name BasicItemUI

@export_category("Editor dependencies")
@export var _icon: TextureRect
@export var _name: Label
@export var _description: Label


func initialize(config: BasicItemConfig) -> void:
	_icon.texture = config.icon
	_name.text = config.display_name
	_description.text = config.description
