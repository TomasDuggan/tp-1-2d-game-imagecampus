extends Node2D
class_name Trap
"""
Escena heredable "trampa" para molestar al heroe
"""

@export var _damage: int
@export var _duration: float
@export var _cooldown: float
@export var _dps: float
@export var _is_permanently_active: bool
@export var _sprite_frames: SpriteFrames

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _hitbox: Hitbox = $Hitbox
@onready var _duration_timer: Timer = $DurationTimer
@onready var _cooldown_timer: Timer = $CooldownTimer


func _ready():
	_hitbox.initialize(self, _damage, _dps, true, Hurtbox.DamageFaction.ENEMY)
	
	_animation.sprite_frames = _sprite_frames
	
	if _is_permanently_active:
		_animation.play("enabled")
		return
	
	_duration_timer.wait_time = _duration
	_duration_timer.one_shot = true
	_duration_timer.timeout.connect(_deactivate)
	
	_cooldown_timer.wait_time = _cooldown
	_cooldown_timer.one_shot = true
	_cooldown_timer.timeout.connect(_activate)
	_cooldown_timer.start()
	
	_deactivate() # Empieza apagada

func _activate() -> void:
	_hitbox.toggle_detection()
	
	_animation.play("enabling")
	await _animation.animation_finished
	_animation.play("enabled")
	
	_duration_timer.start()

func _deactivate() -> void:
	_hitbox.toggle_detection()
	
	_animation.play_backwards("enabling")
	await _animation.animation_finished
	_animation.play("disabled")
	
	_cooldown_timer.start()


#
