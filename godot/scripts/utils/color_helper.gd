extends Object
class_name ColorHelper


# Toma un int y devuelve un color 'basico'. Deterministico
static func int_to_color_hsv(id: int) -> Color:
	var hue = float((id * 97) % 360) / 360.0
	return Color.from_hsv(hue, 0.8, 0.9)
