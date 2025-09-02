extends Node2D
class_name SkillAbstractBehaviour
"""
Clase base para cualquier Skill
"""

var skill_level: int
var caster_cast_point: Vector2
var caster_movement_direction: Vector2


func initialize(generic_config: Resource, skill_level_arg: int) -> void:
	skill_level = skill_level_arg
	downcast_config(generic_config)
	modify_stats_by_level()

func update_caster_position(cast_point_arg: Vector2, caster_movement_direction_arg: Vector2):
	caster_cast_point = cast_point_arg
	caster_movement_direction = caster_movement_direction_arg

func downcast_config(_generic_config: Resource) -> void:
	assert(false, "This method needs to be implemented to have a typed config")

func modify_stats_by_level() -> void:
	assert(false, "This method needs to be implemented to alter stats based on the skill level")
