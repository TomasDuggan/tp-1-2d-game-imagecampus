extends CharacterBody2D
class_name Hero


@onready var _animation: HeroAnimation = $Animation
@onready var _attack: HeroAttack = $Attack

var _horizontal_direction: int # 1 o -1
var _horizontal_speed := 150.0
var _is_selected: bool = true # TODO


func _ready():
	HeroEventBus.hero_swapped.connect(_toggle_selected)
	_attack.attack_performed.connect(_on_attack_performed)
	_attack.initialize(self)

func _process(_delta):
	if !_is_selected:
		return
	
	@warning_ignore("narrowing_conversion") # TODO
	_horizontal_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func _physics_process(_delta):
	velocity.x = _horizontal_direction * _horizontal_speed
	move_and_slide()

func _on_attack_performed() -> void:
	_animation.play_attack_animation()

func _toggle_selected() -> void:
	_is_selected = !_is_selected
	
	if !_is_selected:
		_horizontal_direction = 0

func _exit_tree():
	HeroEventBus.hero_swapped.disconnect(_toggle_selected)








#
