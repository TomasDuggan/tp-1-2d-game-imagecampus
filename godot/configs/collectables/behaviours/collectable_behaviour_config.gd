@abstract
extends Resource
class_name CollectableBehaviourConfig
"""
Config abstracta para comportamiento de collectables.
Debe definir una escena para procesar la logica y config adicional para configurarla
"""

@abstract
func get_behaviour() -> CollectableBehaviour
