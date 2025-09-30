extends Node
"""
Global para escucha eventos y corre los sonidos
"""

var _music_player := AudioStreamPlayer.new()
var _sfx_container := Node.new()

const MUSIC_BUS_NAME := "Music"
const SFX_BUS_NAME := "SFX"


func _ready():
	AudioEventBus.play_music.connect(_on_play_music)
	AudioEventBus.play_sfx.connect(_on_play_sfx)
	
	_music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	_music_player.bus = MUSIC_BUS_NAME
	add_child(_music_player)
	add_child(_sfx_container)

func _on_play_music(stream: AudioStream) -> void:
	_music_player.stream = stream
	_music_player.play()

func _on_play_sfx(stream: AudioStream, volume: float) -> void:
	var sfx_player := AudioStreamPlayer.new()
	sfx_player.bus = SFX_BUS_NAME
	sfx_player.stream = stream
	sfx_player.volume_db = linear_to_db(volume)
	_sfx_container.add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)

func get_music_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(_get_bus_index(MUSIC_BUS_NAME)))

func get_sfx_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(_get_bus_index(SFX_BUS_NAME)))

func change_music_volume(new_value: float) -> void:
	_change_bus_volume(MUSIC_BUS_NAME, new_value)

func change_sfx_volume(new_value: float) -> void:
	_change_bus_volume(SFX_BUS_NAME, new_value)

func _change_bus_volume(bus_name: String, volume_linear: float) -> void:
	AudioServer.set_bus_volume_db(_get_bus_index(bus_name), linear_to_db(volume_linear))

func _get_bus_index(bus_name: String) -> int:
	return AudioServer.get_bus_index(bus_name)

func _exit_tree():
	AudioEventBus.play_music.disconnect(_on_play_music)
	AudioEventBus.play_sfx.disconnect(_on_play_sfx)






#
