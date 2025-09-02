extends CharacterBody2D
class_name Hero
"""
Heroe jugable por el Player, se configura inyectandole HeroConfig
"""

@onready var _animation: UnitAnimation = $Animation

var _config: HeroConfig
var _movement_speed: float

var _movement_direction: Vector2
var _looking_direction: Vector2

var _movement_input_reader := HeroMovementInputReader.new()
var _skills_controller := SkillsController.new()


func initialize(config: HeroConfig) -> void:
	_config = config

func _ready():
	_movement_speed = _config.movement_speed
	_movement_input_reader.initialize(_config.movement_input_key)
	
	_initialize_skills_controller()

func _process(_delta):
	_resolve_movement()
	
	_animation.update_movement_animation(_is_moving(_movement_direction), _looking_direction)
	_skills_controller.update_caster_position(global_position, _looking_direction)

func _resolve_movement() -> void:
	var direction: Vector2 = _movement_input_reader.get_direction()
	
	if _is_moving(direction):  # actualizar solo si hay input
		_looking_direction = direction

	_movement_direction = direction

func _is_moving(direction: Vector2) -> bool:
	return direction != Vector2.ZERO

func _physics_process(_delta):
	velocity = _movement_direction * _movement_speed
	move_and_slide()

func _initialize_skills_controller() -> void:
	add_child(_skills_controller)
	_skills_controller.add_skills(_config.skill_configs, HeroSkillsManager)
