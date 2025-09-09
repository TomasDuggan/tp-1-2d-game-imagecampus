extends Node
class_name CollectablesSpawner

@export var _collectable_scene: PackedScene
@export var _test_collectable: CollectableConfig # TODO
@onready var collectables_container = $"../../Scroll/CollectablesContainer" # TODO



func _ready():
	var collectable_instance: Collectable = _collectable_scene.instantiate()
	
	collectables_container.add_child(collectable_instance)
	collectable_instance.initialize(_test_collectable)
	collectable_instance.global_position = Vector2(300, 0)
	
	var collectable_instance_2: Collectable = _collectable_scene.instantiate()
	
	collectables_container.add_child(collectable_instance_2)
	collectable_instance_2.initialize(_test_collectable)
	collectable_instance_2.global_position = Vector2(300, 50)










#
