extends Node
"""
Global para acceder al progreso del nivel
"""

const TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX := 4

var _current_level_index := 0


func _ready():
	LevelEventBus.level_won.connect(_on_level_won)

func _on_level_won() -> void:
	if !is_final_level():
		_current_level_index += 1

func is_final_level() -> bool:
	return _current_level_index == TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX

func get_current_level_index() -> int:
	return _current_level_index

func force_change_level_debug(level_index: int) -> void:
	_current_level_index = clamp(level_index, 0, TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX)

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)





#
