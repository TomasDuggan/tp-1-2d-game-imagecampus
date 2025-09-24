extends Node
"""
Bus para eventos relacionados a Collectables
"""

signal collectable_amount_changed(type: World.WorldType, amount: int)


func raise_event_collectable_amount_changed(type: World.WorldType, current_amount: int) -> void:
	collectable_amount_changed.emit(type, current_amount)
