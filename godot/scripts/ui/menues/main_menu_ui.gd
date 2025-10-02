extends Control
class_name MainMenuUI

@export_category("Config")
@export var _music: AudioStream

@export_category("Editor Dependencies")
@export var _credits_container: Control

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
