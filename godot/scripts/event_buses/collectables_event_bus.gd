extends Node

@warning_ignore("unused_signal")
signal collectable_amount_changed(type: Enums.WorldType, amount: int)

func raise_event_collectable_amount_changed(type: Enums.WorldType, current_amount: int) -> void:
	collectable_amount_changed.emit(type, current_amount)
