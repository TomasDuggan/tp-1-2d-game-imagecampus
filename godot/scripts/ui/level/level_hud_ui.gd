extends Control
class_name LevelHudUI

@export_category("Editor Dependencies")
@export var _current_level_text: Label

const CURRENT_LEVEL_TEXT := "Level %s %s"
const MAX_LEVEL_TEXT := "(End)"


func _ready():
	_current_level_text.text = CURRENT_LEVEL_TEXT % [
		(LevelProgress.get_current_level_index() + 1),
		MAX_LEVEL_TEXT if LevelProgress.is_final_level() else "",
	]
