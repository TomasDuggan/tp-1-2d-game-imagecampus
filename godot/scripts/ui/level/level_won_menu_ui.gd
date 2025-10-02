extends Control
class_name LevelWonMenuUI


func _ready():
	hide()
	LevelEventBus.level_won.connect(_on_level_won)

func _on_level_won() -> void:
	show()

func _exit_tree():
	LevelEventBus.level_won.disconnect(_on_level_won)
