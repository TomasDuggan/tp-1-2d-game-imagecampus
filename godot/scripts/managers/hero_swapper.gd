extends Node
class_name HeroSwapper

func _unhandled_key_input(event):
	if event.is_action_pressed("swap_hero"):
		HeroEventBus.raise_event_swap_hero()
