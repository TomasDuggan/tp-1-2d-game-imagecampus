extends Node
"""
Global para escucha eventos y corre los sonidos.
- Para sonidos particulares se usa el bus.
- Para eventos (ej HeroSwapped) este manager se conecta ellos
"""

var _music_player := AudioStreamPlayer.new()
var _sfx_pool := Node.new()

const MUSIC_BUS_NAME := "Music"
const SFX_BUS_NAME := "SFX"
const MAX_VOLUME := 1.0
const START_MUSIC_VOLUME := 0.1
const START_SFX_VOLUME := 0.3
const SYNERGY_SFX_VOLUME := 0.8

const ERROR_SFX: AudioStream = preload("uid://7jtvn36vic81")
const SWAP_SFX: AudioStream = preload("uid://crq7t0tgo8h78")
const SYNERGY_SFX: AudioStream = preload("uid://5qmmiom1prwg")
const PURCHASE_SFX: AudioStream = preload("uid://5ky4kodokwy4")
const INTERACTABLE_PRESSED_SFX: AudioStream = preload("uid://bx3ha5tvj4own")


func _ready():
	AudioEventBus.play_music.connect(_on_play_music)
	AudioEventBus.play_sfx.connect(_on_play_sfx)
	
	HeroEventBus.hero_swapped.connect(_on_hero_swapped)
	SynergyEventBus.synergy_effect_activated.connect(_on_synergy_activated)
	UpgradesEventBus.try_buy_upgrade.connect(_on_upgrade_bought)
	InteractablesManager.interactable_pressed.connect(_on_interactable_pressed)
	
	_music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	_music_player.bus = MUSIC_BUS_NAME
	_music_player.finished.connect(_music_player.play) # Loop
	
	add_child(_music_player)
	add_child(_sfx_pool)
	
	change_music_volume(START_MUSIC_VOLUME)
	change_sfx_volume(START_SFX_VOLUME)

func _on_play_music(stream: AudioStream) -> void:
	if stream == _music_player.stream:
		return
	
	_music_player.stream = stream
	_music_player.play()

func _on_hero_swapped(_from, _to, success: bool) -> void:
	_on_play_sfx(_get_sfx_or_use_error_sfx(SWAP_SFX, success))

func _on_upgrade_bought(_upg, success: bool) -> void:
	_on_play_sfx(_get_sfx_or_use_error_sfx(PURCHASE_SFX, success))

func _on_synergy_activated() -> void:
	_on_play_sfx(SYNERGY_SFX, SYNERGY_SFX_VOLUME)

func _on_interactable_pressed(_id) -> void:
	_on_play_sfx(INTERACTABLE_PRESSED_SFX)

func _get_sfx_or_use_error_sfx(sfx: AudioStream, success: bool) -> AudioStream:
	return sfx if success else ERROR_SFX

func _on_play_sfx(stream: AudioStream, volume: float = MAX_VOLUME) -> void:
	var sfx_player: AudioStreamPlayer = _get_sfx_player_from_pool()
	
	sfx_player.stream = stream
	sfx_player.volume_db = linear_to_db(volume)
	sfx_player.play()

func _get_sfx_player_from_pool() -> AudioStreamPlayer:
	for player: AudioStreamPlayer in _sfx_pool.get_children():
		if !player.playing:
			return player
	
	return _create_sfx_player()
	
func _create_sfx_player() -> AudioStreamPlayer:
	var sfx_player := AudioStreamPlayer.new()
	
	sfx_player.bus = SFX_BUS_NAME
	_sfx_pool.add_child(sfx_player)
	
	return sfx_player

func get_music_volume() -> float:
	return _get_bus_linear_volume(MUSIC_BUS_NAME)

func get_sfx_volume() -> float:
	return _get_bus_linear_volume(SFX_BUS_NAME)

func _get_bus_linear_volume(bus_name: String) -> float:
	return AudioServer.get_bus_volume_linear(_get_bus_index(bus_name))

func change_music_volume(linear_value: float) -> void:
	_change_bus_volume(MUSIC_BUS_NAME, linear_value)

func change_sfx_volume(linear_value: float) -> void:
	_change_bus_volume(SFX_BUS_NAME, linear_value)

func _change_bus_volume(bus_name: String, volume_linear: float) -> void:
	AudioServer.set_bus_volume_linear(_get_bus_index(bus_name), volume_linear)

func _get_bus_index(bus_name: String) -> int:
	return AudioServer.get_bus_index(bus_name)

func _exit_tree():
	AudioEventBus.play_music.disconnect(_on_play_music)
	AudioEventBus.play_sfx.disconnect(_on_play_sfx)
	
	HeroEventBus.hero_swapped.disconnect(_on_hero_swapped)
	SynergyEventBus.synergy_effect_activated.disconnect(_on_synergy_activated)
	UpgradesEventBus.try_buy_upgrade.disconnect(_on_upgrade_bought)
	InteractablesManager.interactable_pressed.disconnect(_on_interactable_pressed)





#
