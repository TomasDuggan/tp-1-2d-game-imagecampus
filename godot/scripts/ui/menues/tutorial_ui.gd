extends Control
class_name TutorialUI
"""
Slides para el tutorial
"""

@export_category("Config")
@export var _word_colors: Dictionary[String, Color]

@export_category("Editor Dependencies")
@export var _slides_container: Control # Nota: El orden de los slides en el editor es el que se usa en runtime.
@export var _slide_title: Label # Nota: por simplicidad uso el nombre del nodo
@export var _previous_slide_button: Button
@export var _next_slide_button: Button

enum ChangeSlideType { NEXT, PREVIOUS }

var _slides: Array[Control]
var _current_slide_index := 0


func _ready():
	for slide: Control in _slides_container.get_children():
		slide.hide()
		_slides.append(slide)
	
	for slide_text: RichTextLabel in find_children("*", "RichTextLabel"):
		for key in _word_colors.keys():
			var hex_color: String = _word_colors[key].to_html(true)
			var replacement: String = "[color=%s]%s[/color]" % [hex_color, key]
			slide_text.text = slide_text.text.replace(key, replacement)
	
	_slides.front().show()
	_slide_title.text = _slides[_current_slide_index].name
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
	
	if _current_slide_index == hide_button_index:
		button_to_hide.hide()
	
	var current_slide: Control = _slides[_current_slide_index]
	
	current_slide.show()
	_slide_title.text = _slides[_current_slide_index].name

func _on_close_button_pressed():
	SceneLoadManager.load_main_menu()






#
