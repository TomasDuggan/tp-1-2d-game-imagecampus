extends Node
"""
Bus para eventos relacionados a Level
"""

signal level_won()


func raise_event_level_won() -> void:
	level_won.emit()
