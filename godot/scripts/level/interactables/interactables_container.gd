extends Node2D
class_name InteractablesContainer
"""
Para auto-ligar el interactuable con su trigger entre mundos
Ej: ligar button-1 con door-1
"""

func _enter_tree():
	var i := 0
	
	for c: Node2D in get_children():
		c.set_id(i) # interfaz de puertas y botones
		i += 1
