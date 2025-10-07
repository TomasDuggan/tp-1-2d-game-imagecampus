extends Control
class_name OptionsMenuUI
"""
Menu de opciones (sliders de sonido, botones de reload, quit, etc.)
"""

@export_category("Editor dependencies")
@export var _background: NinePatchRect
@export var _options_container: Container
@export var _playing_options_container: Container
@export var _shop_options_container: Container
@export var _music_slider: Slider
@export var _sfx_slider: Slider

signal resume()
signal retry()

enum MenuMode { PLAYING, SHOP, MAIN_MENU }

var _test_sfx_sound: AudioStream = preload("uid://c2bhh78cx5el1")
var _mode: MenuMode


func initialize(mode: MenuMode) -> void:
	_mode = mode

func _ready():
	if _mode == MenuMode.PLAYING:
		_shop_options_container.hide()
	if _mode == MenuMode.SHOP || _mode == MenuMode.MAIN_MENU:
		_playing_options_container.hide()
	
	_music_slider.value = AudioManager.get_music_volume()
	_sfx_slider.value = AudioManager.get_sfx_volume()
	
	call_deferred("_resize_background_based_on_content_size")

func _resize_background_based_on_content_size() -> void:
	_background.size.y = _options_container.size.y
	_background.position = _options_container.position

func _on_music_slider_value_changed(value: float):
	AudioManager.change_music_volume(value)

func _on_sfx_slider_drag_ended(_value_changed: bool):
	AudioManager.change_sfx_volume(_sfx_slider.value)
	AudioEventBus.raise_event_play_sfx(_test_sfx_sound)

func _on_resume_button_pressed():
	resume.emit()

func _on_retry_button_pressed():
	retry.emit()

func _on_quit_button_pressed():
	get_tree().quit()






#
