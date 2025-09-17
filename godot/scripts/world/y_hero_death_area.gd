extends Area2D
class_name YHeroDeathArea

func _ready():
	body_entered.connect(_on_hero_entered)

func _on_hero_entered(_hero: Hero) -> void:
	print_debug("Hero died.") # TODO
