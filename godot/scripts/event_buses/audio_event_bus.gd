extends Node
"""
Bus para eventos relacionados al audio
"""

signal play_music(stream: AudioStream)
signal play_sfx(stream: AudioStream, volume: float)


func raise_event_play_music(stream: AudioStream) -> void:
	play_music.emit(stream)

func raise_event_play_sfx(stream: AudioStream, linear_volume: float = 1.0) -> void:
	play_sfx.emit(stream, linear_volume)
