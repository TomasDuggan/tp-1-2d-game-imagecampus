extends Node2D
class_name Scroll
"""
Scrollea el contenido (Rooms) hacia abajo (+Y) para simular que Hero avanza.
"""

const BASE_SCROLL_SPEED := 65.0
const SPEED_UP_PER_LEVEL_PERCENTAGE := 0.05 # 5%

var _scroll_speed: float


func _ready():
	_scroll_speed = BASE_SCROLL_SPEED + BASE_SCROLL_SPEED * (SPEED_UP_PER_LEVEL_PERCENTAGE * LevelProgress.get_current_level_index())

func _process(delta: float) -> void:
	position.y += _scroll_speed * delta
