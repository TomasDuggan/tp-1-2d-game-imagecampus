extends Control
class_name TutorialUI
"""
Slides para el tutorial
"""

@export_category("Editor Dependencies")
@export var _slides_container: Control # Nota: El orden de los slides en el editor es el que se usa en runtime.
@export var _previous_slide_button: Button
@export var _next_slide_button: Button

enum ChangeSlideType { NEXT, PREVIOUS }

var _slides: Array[Control]
var _current_slide_index := 0


func _ready():
	for slide: Control in _slides_container.get_children():
		slide.hide()
		_slides.append(slide)
	
	_slides.front().show()
	_previous_slide_button.hide()
	_next_slide_button.show()

func _on_next_slide_button_pressed():
	_change_slide(ChangeSlideType.NEXT)

func _on_previous_slide_button_pressed():
	_change_slide(ChangeSlideType.PREVIOUS)

func _change_slide(type: ChangeSlideType) -> void:
	var new_index: int
	var hide_button_index: int
	var button_to_hide: Button
	
	if type == ChangeSlideType.PREVIOUS:
		new_index = _current_slide_index - 1
		hide_button_index = 0
		button_to_hide = _previous_slide_button
		_next_slide_button.show()
	else:
		new_index = _current_slide_index + 1
		hide_button_index = _slides.size() - 1
		button_to_hide = _next_slide_button
		_previous_slide_button.show()
	
	_slides[_current_slide_index].hide()
	_current_slide_index = new_index
	_slides[_current_slide_index].show()
	
	if _current_slide_index == hide_button_index:
		button_to_hide.hide()

func _on_close_button_pressed():
	SceneLoadManager.load_main_menu()






#
