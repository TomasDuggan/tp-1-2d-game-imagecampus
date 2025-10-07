extends Node
"""
Global para manejar los interactuables
"""

"""
TODO: bug si el minero se adelanta mucho (le aparecen mapas cortos y al warrior largos por ej).
- Creo que se soluciona si al apretar un boton se abren todas las puertas pero no se consume el counter.
- Creo que de alguna manera el boton deberia abrir todas las puertas actuales y guardar un counter para la futura.
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
