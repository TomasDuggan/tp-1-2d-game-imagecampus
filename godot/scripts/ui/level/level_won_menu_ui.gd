extends Control
class_name LevelWonMenuUI
"""
Menu que se abre al ganar un nivel
"""

@export_category("Editor Dependencies")
@export var _level_won_container: Container
@export var _game_won_container: Container


func _ready():
	LevelEventBus.level_won.connect(_on_level_won)
	
	hide()
	_level_won_container.hide()
	_game_won_container.hide()

func _on_level_won() -> void:
	show()
	if LevelProgress.is_final_level():
		_game_won_container.show()
	else:
		_level_won_container.show()

func _on_quit_game_button_pressed():
	get_tree().quit()

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)
