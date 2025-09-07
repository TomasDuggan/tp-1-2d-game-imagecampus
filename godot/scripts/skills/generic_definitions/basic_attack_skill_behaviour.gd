extends SkillAbstractBehaviour
class_name BasicAttackSkillBehaviour
"""
Logica de skill para ataques basicos melee
"""

var _config: BasicAttackSkillConfig

var _damage: int
var _layer_to_affect: int
var _cd_timer := Timer.new()
var _aoe := Area2D.new()
var _targets_in_range: Array[HealthController] = []

const BASIC_ATTACK_ANIMATION_PREFIX := "basic_attack_"

func _ready():
	_set_up_cooldown_timer()
	_set_up_aoe()

func _set_up_cooldown_timer() -> void:
	_cd_timer.wait_time = _config.cooldown
	_cd_timer.one_shot = true
	_cd_timer.autostart = true
	_cd_timer.timeout.connect(_try_to_activate)
	add_child(_cd_timer)

# TODO: la creacion de Area2D va a un static helper
func _set_up_aoe() -> void:
	var collision_shape := CollisionShape2D.new()
	var rectangle_shape := RectangleShape2D.new()
	
	rectangle_shape.set_size(_config.attack_size)
	collision_shape.set_shape(rectangle_shape)
	collision_shape.set_debug_color(Color(1, 1, 0, 0.5))
	
	_aoe.add_child(collision_shape)
	_aoe.collision_mask = _layer_to_affect
	_aoe.area_entered.connect(_on_enemy_entered)
	_aoe.area_exited.connect(_on_enemy_exited)
	_aoe.position += position + resolve_caster_looking_direction() * _config.separation_from_caster
	add_child(_aoe)

func _on_enemy_entered(health_controller: HealthController) -> void:
	_targets_in_range.append(health_controller)
	_try_to_activate()

func _on_enemy_exited(health_controller: HealthController) -> void:
	_targets_in_range.erase(health_controller)

func _try_to_activate() -> void:
	if !_can_activate():
		return
	
	_cd_timer.start()
	request_animation.emit(BASIC_ATTACK_ANIMATION_PREFIX, true)
	_damage_targets()

func _damage_targets() -> void:
	for target: HealthController in _targets_in_range:
		target.receive_damage(_damage)

func _can_activate() -> bool:
	return !_targets_in_range.is_empty() && _cd_timer.is_stopped()

func set_layer_to_affect(layer_to_affect_arg: int) -> void:
	_layer_to_affect = layer_to_affect_arg

func downcast_config(generic_config: Resource) -> void:
	_config = generic_config as BasicAttackSkillConfig

func modify_stats_by_level(skill_level: int) -> void:
	_damage = _config.damage + ceil(_config.damage * _config.damage_modifier_percentage_by_level * skill_level)
