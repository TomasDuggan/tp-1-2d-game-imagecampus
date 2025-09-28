extends StaticBody2D
class_name Door
"""
Escena para puertas bloqueantes
"""

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _physics_collision_shape: CollisionShape2D = $PhysicsCollisionShape
@onready var _key_sprite: Sprite2D = $KeySprite

var _id: int


func _ready():
	if InteractablesManager.is_door_opened(_id):
		_open_door()
	else:
		InteractablesManager.interactable_pressed.connect(_check_open_door)

func _check_open_door(id: int) -> void:
	if _id == id:
		_open_door()

func _open_door() -> void:
	_physics_collision_shape.call_deferred("set_disabled", true)
	_animation.play("open")

# 'interfaz'
func set_id(id: int) -> void:
	_id = id
	_key_sprite.modulate = ColorHelper.int_to_color_hsv(_id)

func _exit_tree():
	if InteractablesManager.interactable_pressed.is_connected(_check_open_door):
		InteractablesManager.interactable_pressed.connect(_check_open_door)
