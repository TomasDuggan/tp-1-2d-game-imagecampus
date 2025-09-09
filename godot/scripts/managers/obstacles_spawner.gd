extends Node
class_name ObstaclesSpawner

@export var _obstacle_scene: PackedScene
@export var _test_obstacle: ObstacleConfig # TODO


func _ready():
	var obstacle_instance: Obstacle = _obstacle_scene.instantiate()
	
	add_child(obstacle_instance)
	obstacle_instance.initialize(_test_obstacle)
	obstacle_instance.global_position = Vector2(300, 0)













#
