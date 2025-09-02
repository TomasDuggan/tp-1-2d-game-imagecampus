extends Resource
class_name SkillConfig
"""
Configuracion de partida para crear cualquier Skill
"""

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var behaviour_config: SkillBehaviourConfig
