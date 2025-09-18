extends Node
class_name HeroSwapper

var _block_swap_timer := Timer.new()


func _ready():
	_block_swap_timer.one_shot = true
	add_child(_block_swap_timer)
	
	HeroEventBus.block_hero_swap.connect(_block_swap)

func _unhandled_key_input(event):
	if event.is_action_pressed("swap_hero") && _block_swap_timer.is_stopped():
		HeroEventBus.raise_event_swap_hero()

func _block_swap(block_duration: float) -> void:
	_block_swap_timer.start(block_duration)

func _exit_tree():
	HeroEventBus.block_hero_swap.disconnect(_block_swap)








#
