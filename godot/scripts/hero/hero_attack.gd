extends Area2D
class_name HeroAttack

signal attack_performed()

var _source: Hero
var _attack_cd_timer := Timer.new()
var _damage: int = 1 # TODO


func initialize(source: Hero) -> void:
	_source = source

func _ready():
	_attack_cd_timer.autostart = true
	_attack_cd_timer.timeout.connect(_on_attack_timeout)
	add_child(_attack_cd_timer)

func _on_attack_timeout() -> void:
	attack_performed.emit()
	
	var collectables_in_range: Array = get_overlapping_bodies()
	
	if collectables_in_range.is_empty():
		return
	
	for collectable: Collectable in collectables_in_range:
		collectable.receive_damage(_source, _damage)







#
