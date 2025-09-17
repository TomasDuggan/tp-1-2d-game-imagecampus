extends Object
class_name Upgrade

var _config: UpgradeConfig
var _current_level: int

func _init(config: UpgradeConfig):
	_config = config
	_current_level = 1

func level_up():
	_current_level += 1

func matches(world_type: Enums.WorldType, upgrade_id: Enums.UpgradeId) -> bool:
	return _config.world_type == world_type && _config.id == upgrade_id

func get_value() -> float:
	return _config.stat_modifier_value * _current_level

func get_config() -> UpgradeConfig:
	return _config
