extends Node

@warning_ignore("unused_signal")
signal hero_swapped()

func raise_event_swap_hero() -> void:
	hero_swapped.emit()
