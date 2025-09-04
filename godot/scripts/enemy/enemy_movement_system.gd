extends Node
class_name EnemyMovementSystem
"""
Pseudo ECS para el movimiento en batch de los enemigos
"""

var _enemies: Array[Enemy] # TODO: diccionario?
var _hero: Hero # TODO: cambiarlo a array

const STOP_DISTANCE_SQ:= pow(30.0, 2)


func set_hero(hero_arg: Hero) -> void:
	_hero = hero_arg

func add_enemy(enemy: Enemy) -> void:
	_enemies.append(enemy)

func _process(delta):
	_move_enemy_batch(delta)

func _move_enemy_batch(delta: float) -> void:
	for enemy: Enemy in _enemies:
		var to_player: Vector2 = _hero.global_position - enemy.global_position
		var dist_sq := to_player.length_squared()

		if dist_sq > STOP_DISTANCE_SQ:
			var dir := to_player.normalized()
			var flat_dir := Vector2.RIGHT if dir.x > 0 else Vector2.LEFT
			
			enemy.global_position += dir * enemy.get_movement_speed() * delta
			
			enemy.update(flat_dir)




#
