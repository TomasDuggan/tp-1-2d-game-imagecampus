extends Node2D
class_name SkillAbstractBehaviour
"""
Clase base para cualquier Skill
"""

@warning_ignore("unused_signal")
signal request_animation(animation_name_prefix: String, halt_caster_movement: bool)


# Public
func initialize(generic_config: Resource, skill_level: int, layer_to_affect: int) -> void:
	downcast_config(generic_config)
	modify_stats_by_level(skill_level)
	set_layer_to_affect(layer_to_affect)

# Protected
func resolve_caster_looking_direction() -> Vector2:
	return Vector2.RIGHT.rotated(global_rotation)  # RIGHT es el 0 de Godot

# Protected
func downcast_config(_generic_config: Resource) -> void:
	assert(false, "This method needs to be implemented to have a typed config")

# Protected
func modify_stats_by_level(_skill_level: int) -> void:
	assert(false, "This method needs to be implemented to alter stats based on the skill level")

# Protected
func set_layer_to_affect(_layer_to_affect: int) -> void:
	pass
