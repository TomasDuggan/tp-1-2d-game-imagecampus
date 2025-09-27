extends Node
"""
Global para info generica del juego
"""

var _current_level := 0


func _ready():
	LevelEventBus.level_won.connect(_on_level_won)

func _on_level_won() -> void:
	_current_level += 1

func get_current_level() -> int:
	return _current_level

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)
