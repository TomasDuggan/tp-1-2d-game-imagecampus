extends CharacterBody2D
class_name Hero
"""
Heroe jugable por el Player, se configura inyectandole HeroConfig
"""

@onready var _combat_unit: CombatUnit = $CombatUnit


var _config: HeroConfig
var _movement_speed: float

var _movement_direction: Vector2
var _looking_direction: Vector2

var _movement_input_reader := HeroMovementInputReader.new()


func initialize(config: HeroConfig) -> void:
	_config = config

func _ready():
	_movement_direction = Vector2.DOWN
	_looking_direction = Vector2.DOWN
	
	_combat_unit.initialize(_config.unit_config, HeroSkillsManager, 4)
	_movement_speed = _config.unit_config.movement_speed

func _process(_delta):
	_resolve_movement()
	
	_combat_unit.update(_is_moving(_movement_direction), _looking_direction)

func _resolve_movement() -> void:
	if !_combat_unit.can_move():
		return
	
	var direction: Vector2 = _movement_input_reader.get_movement_direction()
	
	if _is_moving(direction):  # actualizar solo si hay input
		_looking_direction = direction

	_movement_direction = direction

func _is_moving(direction: Vector2) -> bool:
	return direction != Vector2.ZERO

func _physics_process(_delta):
	velocity = _movement_direction * _movement_speed
	move_and_slide()








#
