extends Area2D
class_name HeroAttack
"""
Ataque del heroe, escanea 'Collectables' y los golpea
"""

signal attack_performed()
signal collectable_destroyed(config: CollectableConfig)

var _source: Hero
var _attack_cd_timer := Timer.new()
var _damage: int = 1 # TODO
var _collectables_in_range: Array[Collectable] = []


func initialize(source: Hero) -> void:
	_source = source

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	_attack_cd_timer.autostart = true
	_attack_cd_timer.timeout.connect(_on_attack_timeout)
	add_child(_attack_cd_timer)

func _on_body_entered(collectable: Collectable) -> void:
	_collectables_in_range.append(collectable)
	collectable.destroyed.connect(_on_collectable_destroyed)

func _on_body_exited(collectable: Collectable) -> void:
	_collectables_in_range.erase(collectable)
	collectable.destroyed.disconnect(_on_collectable_destroyed)

func _on_collectable_destroyed(config: CollectableConfig) -> void:
	collectable_destroyed.emit(config)

func _on_attack_timeout() -> void:
	attack_performed.emit()
	
	for collectable: Collectable in _collectables_in_range:
		collectable.receive_damage(_source, _damage)







#
