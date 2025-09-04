extends Node2D
class_name Level

@onready var _hero_spawner: HeroSpawner = $HeroSpawner
@onready var _enemy_movement_system: EnemyMovementSystem = $EnemySpawner/EnemyMovementSystem


func _ready():
	_enemy_movement_system.set_hero(_hero_spawner.spawn_hero())
