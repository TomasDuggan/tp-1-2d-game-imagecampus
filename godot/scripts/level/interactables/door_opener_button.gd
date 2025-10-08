extends Area2D
class_name DoorOpenerButton

@onready var _sprite_on: Sprite2D = $SpriteOn
@onready var _sprite_off: Sprite2D = $SpriteOff

var _door_to_open_id: int


func _ready():
	_sprite_on.modulate = ColorHelper.int_to_color_hsv(_door_to_open_id)
	_sprite_off.modulate = ColorHelper.int_to_color_hsv(_door_to_open_id)
	
	_sprite_on.set_visible(true)
	_sprite_off.set_visible(false)
	body_entered.connect(_on_hero_entered)

func _on_hero_entered(_hero: Hero) -> void:
	_sprite_on.set_visible(false)
	_sprite_off.set_visible(true)
	InteractablesManager.press_interactable(_door_to_open_id)

# 'interfaz'
func set_id(id: int) -> void:
	_door_to_open_id = id
