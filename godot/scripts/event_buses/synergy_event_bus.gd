extends Node
"""
Bus para eventos del efecto 'Sinergia'
"""

signal synergy_effect_activated()
signal synergy_effect_ended()
signal gain_synergy(normalized_value: float)


func raise_event_synergy_effect_activated() -> void:
	synergy_effect_activated.emit()

func raise_event_synergy_effect_ended() -> void:
	synergy_effect_ended.emit()

func raise_event_gain_synergy(normalized_value: float) -> void:
	gain_synergy.emit(normalized_value)
