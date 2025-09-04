extends Node
class_name EnemySpawner
"""
Spawneador de enemigos en escena
"""

@onready var _enemy_movement_system: EnemyMovementSystem = $EnemyMovementSystem
@onready var _enemy_skills_manager: EnemySkillsManager = $EnemySkillsManager

@export var _enemy_scene: PackedScene # Type: CombatUnit.tscn
@export var _enemy_configs: Array[UnitConfig]


func _ready():
	#return # TODO
	for enemy_config: UnitConfig in _enemy_configs:
		var instance: CombatUnit = _enemy_scene.instantiate()
		
		add_child(instance)
		instance.initialize(enemy_config, _enemy_skills_manager, 16)
		instance.global_position = Vector2(200, 200) # TODO
		_enemy_movement_system.add_enemy(instance)







#
