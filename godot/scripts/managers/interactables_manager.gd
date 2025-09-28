extends Node

signal interactable_pressed(id: int)

var _opened_doors: Dictionary[int, bool] = {}


func press_interactable(id: int) -> void:
	_opened_doors[id] = true
	interactable_pressed.emit(id)

func is_door_opened(id: int) -> bool:
	return _opened_doors.get(id, false)
