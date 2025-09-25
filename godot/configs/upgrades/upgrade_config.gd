extends Resource
class_name UpgradeConfig
"""
Configuracion de una upgrade para comprar en el shop y afectar algun valor del juego.
"""

# Usar PLACEHOLDER en 'description' para reemplazar su valor usando 'stat_modifier_value' y 'level'
const PLACEHOLDER := "X"

@export_category("Config")
@export var id: UpgradesManager.UpgradeId
@export var world_type: World.WorldType
@export var stat_modifier_value: float
@export var max_level: int # En este level deja de aparecer para comprar en el Shop

@export_category("UI")
@export var icon: Texture2D
@export var display_name: String
@export var description: String
@export var price: int
@export var use_percentage_format: bool


func format_description(level: int) -> String:
	var replacement_value: float = stat_modifier_value * level
	
	if use_percentage_format:
		replacement_value *= 100
	
	return description.replace(PLACEHOLDER, str(int(replacement_value)))








#
