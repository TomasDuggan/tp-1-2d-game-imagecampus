extends Control
class_name MainMenuUI

@export_category("Config")
@export var _music: AudioStream

@export_category("Editor Dependencies")
@export var _credits_container: Control

const OPTIONS_MENU_SCENE: PackedScene = preload("uid://bmwvgt0131dh6")



func _ready():
	_credits_container.hide()
	AudioEventBus.raise_event_play_music(_music)

func _on_play_button_pressed():
	SceneLoadManager.load_level()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	_credits_container.show()

func _on_close_credits_button_pressed():
	_credits_container.hide()

func _on_tutorial_button_pressed():
	SceneLoadManager.load_tutorial()

func _on_settings_button_pressed():
	var options_menu: OptionsMenuUI = OPTIONS_MENU_SCENE.instantiate()
	options_menu.initialize(OptionsMenuUI.MenuMode.MAIN_MENU)
	
	options_menu.resume.connect(func(): options_menu.queue_free())
	add_child(options_menu)









#
