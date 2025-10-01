extends Node
"""
Global para manejar los interactuables
"""

signal interactable_pressed(id: int)

var _pressed_interactables_counter: Dictionary[int, int] = {} # id -> counter


func press_interactable(id: int) -> void:
	_pressed_interactables_counter[id] = _pressed_interactables_counter.get(id, 0) + 1
	interactable_pressed.emit(id)

func is_door_opened(id: int) -> bool:
	return _pressed_interactables_counter.get(id, 0) > 0

func consume_counter(id: int) -> void:
	if _pressed_interactables_counter.has(id):
		_pressed_interactables_counter[id] -= 1
		if _pressed_interactables_counter[id] <= 0:
			_pressed_interactables_counter.erase(id)
