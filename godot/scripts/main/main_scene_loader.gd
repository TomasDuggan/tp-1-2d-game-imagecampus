extends Node
class_name MainSceneLoader
"""
Swappea entre las escenas 'principales/main': Level y ShopUI
"""

const LEVEL_SCENE: PackedScene = preload("uid://cw7v32643ol2t")
const SHOP_SCENE: PackedScene = preload("uid://41r7gy6mk5f7")

var _current_main_scene: Node


func _ready():
	LevelEventBus.level_won.connect(_on_level_won)
	
	_load_level()

func _load_level() -> void:
	_unload_current_main_scene()
	
	var level_instance: Level = LEVEL_SCENE.instantiate()
	_current_main_scene = level_instance
	add_child(level_instance)

func _on_level_won() -> void:
	_load_shop()

func _load_shop() -> void:
	_unload_current_main_scene()
	
	var shop_instance: ShopUI = SHOP_SCENE.instantiate()
	shop_instance.exit_shop.connect(_on_exit_shop_request, CONNECT_ONE_SHOT)
	_current_main_scene = shop_instance
	add_child(shop_instance)

func _on_exit_shop_request() -> void:
	_load_level()

func _unload_current_main_scene() -> void:
	if _current_main_scene != null:
		_current_main_scene.queue_free()
	
func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)













#
