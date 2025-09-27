extends Resource
class_name RoomConfig

@export var scene: PackedScene
@export var min_level_to_show: int
@export var  is_end_room: bool
@export_range(0.0, 1.0, 0.1) var appearance_weight: float = 0.5
