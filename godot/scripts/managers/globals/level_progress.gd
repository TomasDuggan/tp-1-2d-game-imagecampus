extends Node
"""
Global para acceder al progreso del nivel
"""

const TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX := 4

var _current_level_index := 0


func _ready():
	LevelEventBus.level_won.connect(_on_level_won)

func _on_level_won() -> void:
	_set_level_index(_current_level_index + 1)

func is_final_level() -> bool:
	return _current_level_index == TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX

func get_current_level_index() -> int:
	return _current_level_index

func force_change_level_debug(level_index: int) -> void:
	_set_level_index(level_index)

func _set_level_index(new_level_index: int) -> void:
	_current_level_index = clamp(new_level_index, 0, TOTAL_AMOUNT_OF_LEVELS_TO_PLAY_INDEX)

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)





#
