extends Node
class_name EnemyMovementSystem
"""
Pseudo sistema estilo ECS para el movimiento en batch de los enemigos
"""

var _enemies: Array[CombatUnit] # TODO: diccionario?
var _hero: Hero # TODO: cambiarlo a array

const STOP_DISTANCE_SQ:= pow(30.0, 2)

func set_hero(hero_arg: Hero) -> void:
	_hero = hero_arg

func add_enemy(enemy: CombatUnit) -> void:
	_enemies.append(enemy)
	enemy.death.connect(_on_enemy_death)

func _on_enemy_death(enemy: CombatUnit) -> void:
	_enemies.erase(enemy)
	enemy.queue_free()

func _process(delta):
	_move_enemy_batch(delta)

func _move_enemy_batch(delta: float) -> void:
	for enemy: CombatUnit in _enemies:
		if !enemy.can_move():
			return
		
		var to_player: Vector2 = _hero.global_position - enemy.global_position
		var to_player_normalized: Vector2 = to_player.normalized()
		var raw_enemy_dir := Vector2.RIGHT if to_player_normalized.x > 0 else Vector2.LEFT
		var close_to_player = to_player.length_squared() <= STOP_DISTANCE_SQ
		
		enemy.update(!close_to_player, raw_enemy_dir)
		
		if !close_to_player:
			enemy.global_position += to_player_normalized * enemy.get_config().movement_speed * delta



#
