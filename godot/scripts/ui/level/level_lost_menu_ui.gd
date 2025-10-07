extends Control
class_name LevelLostMenuUI
"""
Menu que se abre al perder un nivel
"""

func _ready():
	hide()
	LevelEventBus.level_lost.connect(_on_level_lost)

func _on_level_lost() -> void:
	show()

func _exit_tree():
	LevelEventBus.level_lost.disconnect(_on_level_lost)

func _on_retry_level_button_pressed():
	SceneLoadManager.reload()
