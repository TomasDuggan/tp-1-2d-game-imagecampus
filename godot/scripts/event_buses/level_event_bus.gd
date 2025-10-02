extends Node
"""
Bus para eventos relacionados a Level
"""

signal level_won()
signal level_lost()


func raise_event_level_won() -> void:
	level_won.emit()

func raise_event_level_lost() -> void:
	level_lost.emit()
