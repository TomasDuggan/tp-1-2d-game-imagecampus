extends Node
"""
Global para cargar escenas importantes
"""

const LEVEL_SCENE: PackedScene = preload("uid://cw7v32643ol2t")
const SHOP_SCENE: PackedScene = preload("uid://41r7gy6mk5f7")
const MAIN_MENU_SCENE: PackedScene = preload("uid://sbseylgpog5c")
const TUTORIAL_SCENE: PackedScene = preload("uid://dmbqul4rm3vvb")



func load_level() -> void:
	_unpause()
	get_tree().change_scene_to_packed(LEVEL_SCENE)

func load_shop() -> void:
	_unpause()
	get_tree().change_scene_to_packed(SHOP_SCENE)

func load_main_menu() -> void:
	_unpause()
	get_tree().change_scene_to_packed(MAIN_MENU_SCENE)

func load_tutorial() -> void:
	_unpause()
	get_tree().change_scene_to_packed(TUTORIAL_SCENE)

func reload_current_scene() -> void:
	_unpause()
	get_tree().reload_current_scene()

# Por las dudas
func _unpause() -> void:
	get_tree().paused = false










#
