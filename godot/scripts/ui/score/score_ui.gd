extends HBoxContainer
class_name ScoreUI
"""
UI para mostrar el score actual
"""

@onready var _score_icon: TextureRect = $ScoreIcon
@onready var _score_amount: Label = $ScoreAmount

var _world_type: Enums.WorldType

const ICONS_BY_WORLD_TYPE := {
	Enums.WorldType.MINER: preload("uid://bm8eqm7pjupgf"),
	Enums.WorldType.WARRIOR: preload("uid://ccwrpax3qwusa"),
}


func initialize(world_type: Enums.WorldType) -> void:
	_world_type = world_type
	
	_initialize_score()

func _initialize_score() -> void:
	_score_icon.texture = ICONS_BY_WORLD_TYPE[_world_type]
	_score_amount.text = str(CollectablesManager.get_current_amount(_world_type))

func _ready():
	CollectableEventBus.collectable_amount_changed.connect(_on_score_changed)

func _on_score_changed(type: Enums.WorldType, current_amount: int) -> void:
	if type == _world_type:
		_score_amount.text = str(current_amount)

func _exit_tree():
	CollectableEventBus.collectable_amount_changed.disconnect(_on_score_changed)










#
