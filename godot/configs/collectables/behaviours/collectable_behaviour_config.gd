extends Resource
class_name CollectableBehaviourConfig
"""
Config abstracta para comportamiento de collectables.
Debe definir una escena para procesar la logica y config adicional para configurarla
"""

func get_behaviour_scene() -> PackedScene: # Type: CollectableBehaviour
	assert(false, "A behaviour must be linked to a scene")
	return null
