extends Node
class_name EnemySpawner
"""
Spawneador de enemigos en escena
"""

@onready var _enemy_movement_system: EnemyMovementSystem = $EnemyMovementSystem
@onready var _enemy_skills_manager: EnemySkillsManager = $EnemySkillsManager

@export var _enemy_scene: PackedScene
@export var _enemy_configs: Array[UnitConfig]


func _ready():
	#return # TODO
	for enemy_config: UnitConfig in _enemy_configs:
		var instance: Enemy = _enemy_scene.instantiate()
		
		instance.initialize(enemy_config, _enemy_skills_manager)
		add_child(instance)
		instance.global_position = Vector2(200, 200)
		_enemy_movement_system.add_enemy(instance)
