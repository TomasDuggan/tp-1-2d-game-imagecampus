extends Node
class_name VerticalSpeedBoostHandler
"""
Manejador del boost en eje Y que recibe el heroe al destruir un collectable
"""


signal vertical_speed_changed(new_vertical_speed: float)

var _vertical_speed_boost_timer := Timer.new()

const USUAL_VERTICAL_SPEED := 0.0 # TODO: rename, usual?
const VERTICAL_SPEED_BOOST := -100.0


func _ready():
	_vertical_speed_boost_timer.one_shot = true
	add_child(_vertical_speed_boost_timer)

func on_target_destroyed(collectable: Collectable) -> void:
	if _vertical_speed_boost_timer.is_stopped():
		_vertical_speed_boost_timer.timeout.connect(_on_speed_boost_expired, CONNECT_ONE_SHOT)
	
	_vertical_speed_boost_timer.start(collectable.get_destroyed_velocity_boost_duration())
	
	vertical_speed_changed.emit(VERTICAL_SPEED_BOOST)

func _on_speed_boost_expired() -> void:
	vertical_speed_changed.emit(USUAL_VERTICAL_SPEED)
