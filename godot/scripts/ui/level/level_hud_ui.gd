extends Control
class_name LevelHudUI

@export_category("Editor Dependencies")
@export var _current_level_text: Label

const CURRENT_LEVEL_TEXT := "Level %s"


func _ready():
	_current_level_text.text = CURRENT_LEVEL_TEXT % (GameInfo.get_current_level() + 1)
