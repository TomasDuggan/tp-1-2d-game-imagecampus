extends Resource
class_name RoomConfig


@export var scene: PackedScene
@export var min_level_to_show: int
@export var max_level_to_show: int = 4
@export var is_start_room: bool
@export var is_end_room: bool
@export var amount_of_interactables: int # Puertas, botones, etc.
@export_range(0.0, 1.0, 0.1) var appearance_weight: float = 0.5

func get_appearance_weight() -> float:
	return 0.0 if (is_end_room || is_start_room) else appearance_weight

func has_interactables() -> bool:
	return amount_of_interactables > 0
