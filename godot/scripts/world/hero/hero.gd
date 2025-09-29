extends CharacterBody2D
class_name Hero
"""
Script root para las escenas Hero (Minero o Guerrero)
"""

@onready var _hitbox: Hitbox = $Hitbox
@onready var _animation: HeroAnimation = $Animation
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _velocity_boost_particles: CPUParticles2D = $VelocityBoostParticles
@onready var hp: Hurtbox = $Hurtbox # 'Facade'

var _config: HeroConfig
var _horizontal_direction: int # 1 o -1
var _horizontal_movement_input_reader := HeroHorizontalMovementInputReader.new()
var _horizontal_movement_speed: float
var _vertical_speed := 0.0
var _vertical_speed_boost_handler := VerticalSpeedBoostHandler.new()
var _is_selected: bool
var ally: Hero


func initialize(config: HeroConfig, world_type: World.WorldType) -> void:
	_config = config
	_animation.initialize(config.get_sprite_frames(world_type))
	_vertical_speed_boost_handler.initialize(_velocity_boost_particles)
	
	_initialize_hitbox(world_type)
	_initialize_hurtbox()
	_initialize_horizontal_movement_speed(world_type)
	_initialize_input_reader(world_type)

func _initialize_hitbox(world_type: World.WorldType) -> void:
	var upgraded_damage: int = _config.damage + int(UpgradesManager.get_modifier_value(world_type, UpgradesManager.UpgradeId.DAMAGE))
	_hitbox.initialize(self, upgraded_damage, _config.attack_speed, true, Hurtbox.DamageFaction.HERO)
	
	_hitbox.attack_performed.connect(_animation.play_attack_animation)
	_hitbox.target_destroyed.connect(_vertical_speed_boost_handler.on_target_destroyed)

func _initialize_hurtbox() -> void:
	hp.initialize(self, _config.hp, Hurtbox.DamageFaction.HERO, true)
	hp.hit.connect(func(): _animation_player.play("hit"))
	hp.healed.connect(func(): _animation_player.play("heal"))

func _initialize_horizontal_movement_speed(world_type: World.WorldType) -> void:
	var speed: float = _config.horizontal_movement_speed
	speed += speed * UpgradesManager.get_modifier_value(world_type, UpgradesManager.UpgradeId.HORIZONTAL_MOVEMENT_SPEED)
	_horizontal_movement_speed = speed

func _initialize_input_reader(world_type: World.WorldType) -> void:
	add_child(_horizontal_movement_input_reader)
	_horizontal_movement_input_reader.initialize(World.is_warrior_world(world_type))

func _ready():
	_vertical_speed_boost_handler.vertical_speed_changed.connect(_on_vertical_speed_changed)
	add_child(_vertical_speed_boost_handler)

func _process(_delta):
	_horizontal_direction = _horizontal_movement_input_reader.get_horizontal_input_direction()

func _physics_process(delta: float) -> void:
	_move(delta)

# El movimiento lateral es siempre absoluto, el vertical se traba contra obstaculos.
func _move(delta: float) -> void:
	velocity.x = _horizontal_direction * _horizontal_movement_speed
	velocity.y = _vertical_speed

	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision != null:
		if abs(collision.get_normal().y) > 0.9: # Colision bloquea eje Y
			velocity.y = 0 # "Trabarse" verticalmente
		global_position.x += velocity.x * delta # Movimiento lateral libre

func is_selected() -> bool:
	return _is_selected

func select() -> void:
	_update_selection(true)

func deselect() -> void:
	_update_selection(false)

func _update_selection(is_selected_arg: bool) -> void:
	_is_selected = is_selected_arg
	
	_animation.toggle_selected(_is_selected)
	set_process(_is_selected)
	
	if !_is_selected:
		_horizontal_direction = 0

func _on_vertical_speed_changed(new_vertical_speed: float) -> void:
	_vertical_speed = new_vertical_speed

func set_ally(ally_arg: Hero) -> void:
	ally = ally_arg







#
