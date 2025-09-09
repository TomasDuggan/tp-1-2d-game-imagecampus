extends Node
class_name VerticalSpeedBoostHandler

signal vertical_speed_changed(new_vertical_speed: float)

var _vertical_speed_boost_timer := Timer.new()

const NORMAL_VERTICAL_SPEED := 0.0 # TODO: rename, normal?
const VERTICAL_SPEED_BOOST := -100.0


func _ready():
	_vertical_speed_boost_timer.one_shot = true
	add_child(_vertical_speed_boost_timer)

func on_collectable_destroyed(config: CollectableConfig) -> void:
	if _vertical_speed_boost_timer.is_stopped():
		_vertical_speed_boost_timer.timeout.connect(_on_speed_boost_expired)
	
	_vertical_speed_boost_timer.start(config.destroyed_velocity_boost_duration)
	
	vertical_speed_changed.emit(VERTICAL_SPEED_BOOST)

func _on_speed_boost_expired() -> void:
	vertical_speed_changed.emit(NORMAL_VERTICAL_SPEED)
