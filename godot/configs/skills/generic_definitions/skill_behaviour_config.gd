extends Resource
class_name SkillBehaviourConfig
"""
Configuracion del comportamiento de un Skill
- Logica -> behaviour
- Datos -> config
"""

@export var behaviour: Script # Type: SkillAbstractBehaviour
@export var config: Resource
