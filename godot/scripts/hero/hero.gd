extends CharacterBody2D
class_name Hero
"""
Script root para las escenas Hero (Minero o Guerrero)
"""


@onready var _hitbox: Hitbox = $Hitbox
@onready var _animation: HeroAnimation = $Animation
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var hp: Hurtbox = $Hurtbox # 'Facade'

var _config: HeroConfig
var _horizontal_direction: int # 1 o -1
var _horizontal_speed := 150.0
var _vertical_speed := 0.0
var _is_selected: bool
var ally: Hero


func initialize(config: HeroConfig) -> void:
	_config = config
	
	_is_selected = config.start_selected
	set_process(_is_selected)
	
	_hitbox.initialize(self, _config.damage, _config.attack_speed, true, Enums.DamageFaction.HERO)
	hp.initialize(self, _config.hp, Enums.DamageFaction.HERO, true)

func _ready():
	HeroEventBus.hero_swapped.connect(_toggle_selected)
	
	var vertical_speed_boost_handler := VerticalSpeedBoostHandler.new()
	vertical_speed_boost_handler.vertical_speed_changed.connect(_on_vertical_speed_changed)
	add_child(vertical_speed_boost_handler)
	
	_hitbox.attack_performed.connect(_animation.play_attack_animation)
	_hitbox.target_destroyed.connect(vertical_speed_boost_handler.on_target_destroyed)
	
	hp.hit.connect(func(): _animation_player.play("hit"))
	hp.healed.connect(func(): _animation_player.play("heal"))

func _process(_delta):
	_horizontal_direction = int(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))

func _physics_process(_delta):
	velocity.x = _horizontal_direction * _horizontal_speed
	velocity.y = _vertical_speed
	move_and_slide()

func _toggle_selected() -> void:
	_is_selected = !_is_selected
	
	set_process(_is_selected)
	
	if !_is_selected:
		_horizontal_direction = 0

func _on_vertical_speed_changed(new_vertical_speed: float) -> void:
	_vertical_speed = new_vertical_speed

func set_ally(ally_arg: Hero) -> void:
	ally = ally_arg

func _exit_tree():
	HeroEventBus.hero_swapped.disconnect(_toggle_selected)








#
