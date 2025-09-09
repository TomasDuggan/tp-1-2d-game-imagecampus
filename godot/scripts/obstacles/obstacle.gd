extends StaticBody2D
class_name Obstacle
"""
Un bloque que se mueve hacia abajo, arrastrando al Hero si lo toca.
Puede configurarse para que sea destruible y gatille efectos
"""

@onready var _sprite: Sprite2D = $Sprite
@onready var _physics_collision_shape: CollisionShape2D = $PhysicsCollisionShape

var _vertical_speed := 75.0


func initialize(config: ObstacleConfig) -> void:
	if config.texture != null:
		_sprite.texture = config.texture
	
	if config.collectable_config != null:
		var collectable := Collectable.new()
		
		collectable.initialize(config.collectable_config)
		collectable.add_child(_physics_collision_shape.duplicate())
		add_child(collectable)
		collectable.destroyed.connect(func(): queue_free(), CONNECT_ONE_SHOT)

func _physics_process(delta):
	global_position.y += _vertical_speed * delta





#
