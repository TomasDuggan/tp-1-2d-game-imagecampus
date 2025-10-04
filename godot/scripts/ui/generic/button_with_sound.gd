extends Button
class_name ButtonWithSound

var _hover_sound: AudioStream = preload("uid://c2bhh78cx5el1")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered() -> void:
	if _hover_sound:
		AudioEventBus.raise_event_play_sfx(_hover_sound)
