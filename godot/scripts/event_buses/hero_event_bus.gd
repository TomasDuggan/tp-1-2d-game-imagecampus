extends Node
"""
Bus para eventos relacionados a Hero
"""

signal hero_won_world(hero: Hero)
signal hero_lost_world(hero: Hero)
signal hero_swapped(from: Hero, to: Hero, success: bool)
signal block_hero_swap(block_duration: float)


func raise_event_hero_won_world(hero: Hero) -> void:
	hero_won_world.emit(hero)

func raise_event_hero_lost_world(hero: Hero) -> void:
	hero_lost_world.emit(hero)

func raise_event_swap_hero(from: Hero, to: Hero, success: bool) -> void:
	hero_swapped.emit(from, to, success)

func raise_event_block_hero_swap(block_duration: float) -> void:
	block_hero_swap.emit(block_duration)
