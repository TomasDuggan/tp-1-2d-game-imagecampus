extends HBoxContainer
class_name ScoreUI
"""
UI para mostrar el score actual
"""

@onready var _score_icon: TextureRect = $ScoreIcon
@onready var _score_amount: Label = $ScoreAmount


var _collectable_type: Enums.CollectableType

const MINER_ICON = preload("uid://bm8eqm7pjupgf")
const WARRIOR_ICON = preload("uid://ccwrpax3qwusa")


func initialize(collectable_type: Enums.CollectableType) -> void:
	_collectable_type = collectable_type
	
	_initialize_score()

func _initialize_score() -> void:
	if _collectable_type == Enums.CollectableType.MINERAL:
		_score_icon.texture = MINER_ICON
	else:
		_score_icon.texture = WARRIOR_ICON
	
	_score_amount.text = str(CollectablesManager.get_current_amount(_collectable_type))

func _ready():
	CollectableEventBus.collectable_amount_changed.connect(_on_score_changed)

func _on_score_changed(type: Enums.CollectableType, current_amount: int) -> void:
	if type == _collectable_type:
		_score_amount.text = str(current_amount)

func _exit_tree():
	CollectableEventBus.collectable_amount_changed.disconnect(_on_score_changed)










#
