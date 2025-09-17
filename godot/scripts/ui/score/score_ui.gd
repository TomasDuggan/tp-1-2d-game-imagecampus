extends HBoxContainer
class_name ScoreUI
"""
UI para mostrar el score actual
"""

@onready var _score_icon: TextureRect = $ScoreIcon
@onready var _score_amount: Label = $ScoreAmount


var _collectable_type: Enums.CollectableType

const ICONS_BY_COLLECTABLE_TYPE := {
	Enums.CollectableType.MINERAL: preload("uid://bm8eqm7pjupgf"),
	Enums.CollectableType.ENEMY: preload("uid://ccwrpax3qwusa"),
}

func initialize(collectable_type: Enums.CollectableType) -> void:
	_collectable_type = collectable_type
	
	_initialize_score()

func _initialize_score() -> void:
	_score_icon.texture = ICONS_BY_COLLECTABLE_TYPE[_collectable_type]
	_score_amount.text = str(CollectablesManager.get_current_amount(_collectable_type))

func _ready():
	CollectableEventBus.collectable_amount_changed.connect(_on_score_changed)

func _on_score_changed(type: Enums.CollectableType, current_amount: int) -> void:
	if type == _collectable_type:
		_score_amount.text = str(current_amount)

func _exit_tree():
	CollectableEventBus.collectable_amount_changed.disconnect(_on_score_changed)










#
