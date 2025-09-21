extends Node
"""
Bus para eventos relacionados a los objetos interactuables
"""

signal interactable_pressed(target_id: int)


func raise_event_interactable_pressed(target_id: int) -> void:
	interactable_pressed.emit(target_id)
