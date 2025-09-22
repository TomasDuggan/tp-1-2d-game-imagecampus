extends Resource
class_name UpgradeConfig
"""
Configuracion de una upgrade para comprar en el shop y afectar algun valor del juego
"""

@export_category("Config")
@export var id: Enums.UpgradeId
@export var world_type: Enums.WorldType
@export var stat_modifier_value: float

@export_category("UI")
@export var icon: Texture2D
@export var display_name: String
@export var description: String
@export var price: int
