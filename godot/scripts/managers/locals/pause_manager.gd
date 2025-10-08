extends Node
class_name PauseManager
"""
Manager de pausa durante gameplay
"""

@export_category("Editor dependencies")
@export var _canvas_layer: CanvasLayer

const PAUSE_MENU_SCENE: PackedScene = preload("uid://bmwvgt0131dh6")
const pause_action_name := "pause"

var _pause_menu_cache: OptionsMenuUI
var _level_won: bool # Para que no pause post ganar


func _ready():
	LevelEventBus.level_won.connect(_on_level_ended)
	LevelEventBus.level_lost.connect(_on_level_ended)
	
	_pause_menu_cache = PAUSE_MENU_SCENE.instantiate()
	_pause_menu_cache.initialize(OptionsMenuUI.MenuMode.PLAYING)
	
	_pause_menu_cache.resume.connect(_on_resume_pressed)
	_pause_menu_cache.retry.connect(_on_retry_pressed)
	
	_pause_menu_cache.hide()
	_canvas_layer.add_child(_pause_menu_cache)

func _on_resume_pressed() -> void:
	get_tree().paused = false
	_pause_menu_cache.hide()

func _on_retry_pressed() -> void:
	var tree: SceneTree = get_tree()
	tree.paused = false
	SceneLoadManager.reload_current_scene()

func _on_level_ended() -> void:
	_level_won = true

func _unhandled_key_input(event: InputEvent):
	if !_level_won && event.is_action_pressed("pause"):
		var tree: SceneTree = get_tree()
		tree.paused = !tree.paused
		_pause_menu_cache.set_visible(tree.paused)

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_ended)
	LevelEventBus.level_lost.disconnect(_on_level_ended)




#
