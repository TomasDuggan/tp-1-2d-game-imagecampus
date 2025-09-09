extends Node
class_name CollectablesSpawner

@export var _collectable_scene: PackedScene
@export var _test_collectable: CollectableConfig # TODO
@onready var collectables_spawner = $"../Scroll/CollectablesSpawner" # TODO


func _ready():
	var collectable_instance: Collectable = _collectable_scene.instantiate()
	
	collectables_spawner.add_child(collectable_instance)
	collectable_instance.initialize(_test_collectable)
	collectable_instance.global_position = Vector2(300, 0)













#
