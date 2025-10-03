extends CollectableBehaviour
class_name HeroTeleporterCollectableBehaviour
"""
Teletransporta al heroe frente a este collectable
"""

@onready var _teleport_area: Area2D = $TeleportArea

const TELEPORT_OFFSET :=  Vector2(0, 50)
const TELEPORT_EFFECT_SCENE: PackedScene = preload("uid://bvbop7aerytet")

var _teleport_radius: float


func _ready():
	_initialize_teleport_area()

func _initialize_teleport_area() -> void:
	var teleport_config := config as HeroTeleporterBehaviourConfig
	_teleport_radius = teleport_config.teleport_radius
	
	var teleport_collision_shape := CollisionShape2D.new()
	var circle_shape := CircleShape2D.new()
	
	teleport_collision_shape.shape = circle_shape
	circle_shape.radius = _teleport_radius
	
	_teleport_area.add_child(teleport_collision_shape)

func _draw():
	draw_circle(Vector2.ZERO, _teleport_radius, Color.INDIAN_RED, false, 0.8)

func _on_teleport_area_body_entered(hero: Hero):
	if !hero.is_selected():
		_create_particle_effect(hero.global_position)
		hero.global_position = global_position + TELEPORT_OFFSET

func _create_particle_effect(pos: Vector2) -> void:
	var effect_instance: CPUParticles2D = TELEPORT_EFFECT_SCENE.instantiate()
	
	effect_instance.one_shot = true
	effect_instance.emitting = true
	add_child(effect_instance)
	effect_instance.global_position = pos

func on_destroyed_by_hero(_source: Hero) -> void:
	pass









#
