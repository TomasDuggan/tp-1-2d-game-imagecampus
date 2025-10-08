extends Area2D
class_name YHeroDeathArea

var _won_world_heroes: Array[Hero] = []


func _ready():
	HeroEventBus.hero_won_world.connect(_on_hero_won_world)
	body_entered.connect(_on_hero_entered)

func _on_hero_won_world(hero: Hero) -> void:
	_won_world_heroes.append(hero)

func _on_hero_entered(hero: Hero) -> void:
	if !_won_world_heroes.has(hero):
		HeroEventBus.raise_event_hero_lost_world(hero)

func _exit_tree():
	HeroEventBus.hero_won_world.disconnect(_on_hero_won_world)
