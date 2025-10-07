extends Control
class_name CheatMenu
"""
God mode para debugging
"""


func _ready():
	hide()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("cheat"):
		visible = !visible

# Nota: int('asd') == 0
func _on_select_level_input_text_submitted(level: String):
	LevelProgress.force_change_level_debug(int(level))

func _on_get_money_button_pressed():
	CollectablesManager.add_collectables(World.WorldType.MINER, 1000)
	CollectablesManager.add_collectables(World.WorldType.WARRIOR, 1000)
