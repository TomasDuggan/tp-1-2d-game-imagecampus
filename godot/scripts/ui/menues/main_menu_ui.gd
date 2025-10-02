extends Control
class_name MainMenuUI


@export var _music: AudioStream

func _ready():
	AudioEventBus.raise_event_play_music(_music)

func _on_play_button_pressed():
	SceneLoadManager.load_level()

func _on_quit_button_pressed():
	get_tree().quit()
