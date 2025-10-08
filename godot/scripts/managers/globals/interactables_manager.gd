extends Node
"""
Global para manejar los interactuables
"""


signal interactable_pressed(id: int)

var _pressed_interactables_counter: Dictionary[int, int] = {} # id -> counter


func _ready():
	LevelEventBus.level_won.connect(_on_level_ended)
	LevelEventBus.level_lost.connect(_on_level_ended)

func _on_level_ended() -> void:
	_pressed_interactables_counter.clear() # Global con estado...

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

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_ended)
	LevelEventBus.level_lost.disconnect(_on_level_ended)
