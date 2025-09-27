extends Resource
class_name RoomConfig


@export var scene: PackedScene
@export var min_level_to_show: int
@export var is_end_room: bool
@export var has_interactables: bool # Puertas, botones, etc.
@export_range(0.0, 1.0, 0.1) var appearance_weight: float = 0.5

func get_appearance_weight() -> float:
	return 0.0 if is_end_room else appearance_weight
