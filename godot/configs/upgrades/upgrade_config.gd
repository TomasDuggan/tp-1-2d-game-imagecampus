extends Resource
class_name UpgradeConfig
"""
Configuracion de una upgrade para comprar en el shop y afectar algun valor del juego
"""


@export var id: Enums.UpgradeId
@export var world_type: Enums.WorldType
@export var display_name: String
@export var description: String
@export var price: int
@export var stat_modifier_value: float
