extends StaticBody2D
class_name Door

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _physics_collision_shape: CollisionShape2D = $PhysicsCollisionShape

var _id: int


func _ready():
	InteractablesEventBus.interactable_pressed.connect(_check_open_door)

func _destroy(_attacker, _defender) -> void:
	queue_free()

func _check_open_door(id: int) -> void:
	if _id != id:
		return
	
	_physics_collision_shape.call_deferred("set_disabled", true)
	_animation.play("open")

# 'interfaz'
func set_id(id: int) -> void:
	_id = id

func _exit_tree():
	InteractablesEventBus.interactable_pressed.disconnect(_check_open_door)
