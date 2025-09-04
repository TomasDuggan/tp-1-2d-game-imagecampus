extends CharacterBody2D
class_name Hero
"""
Heroe jugable por el Player, se configura inyectandole HeroConfig
"""

@onready var _animation: UnitAnimation = $Animation
@onready var _combat_unit: CombatUnit = $CombatUnit


var _config: HeroConfig
var _movement_speed: float

var _movement_direction: Vector2
var _looking_direction: Vector2

var _movement_input_reader := HeroMovementInputReader.new()


func initialize(config: HeroConfig) -> void:
	_config = config

func _ready():
	_initialize_combat_unit()
	_animation.sprite_frames = _config.unit_config.sprite_frames
	_movement_speed = _config.unit_config.movement_speed

func _process(_delta):
	_resolve_movement()
	
	_animation.update_movement_animation(_is_moving(_movement_direction), _looking_direction)
	_combat_unit.rotate_unit_anchor(_looking_direction)

func _initialize_combat_unit() -> void:
	_combat_unit.initialize(_config.unit_config, HeroSkillsManager, 4)
	_combat_unit.skill_animation_request.connect(_on_skill_requested_animation)

func _resolve_movement() -> void:
	var direction: Vector2 = _movement_input_reader.get_movement_direction()
	
	if _is_moving(direction):  # actualizar solo si hay input
		_looking_direction = direction

	_movement_direction = direction

func _is_moving(direction: Vector2) -> bool:
	return direction != Vector2.ZERO

func _physics_process(_delta):
	if !_animation.can_move():
		return
	
	velocity = _movement_direction * _movement_speed
	move_and_slide()

func _on_skill_requested_animation(animation_name_prefix: String, halt_movement: bool) -> void:
	_animation.play_skill_animation(animation_name_prefix, _looking_direction, halt_movement)










#
