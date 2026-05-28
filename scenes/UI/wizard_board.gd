extends Control

var player_node: Node2D
signal upgrade_happened

func _on_button_pressed() -> void:
	if ScoreManager.bones >= 100:
		ScoreManager.bones -= 100
		GlobalValues.damage_upgrades += 1
		upgrade_happened.emit()

func _on_button_2_pressed() -> void:
	if ScoreManager.bones >= 100:
		ScoreManager.bones -= 100
		GlobalValues.fire_rate_upgrades += 1
		upgrade_happened.emit()

func _on_button_3_pressed() -> void:
	if ScoreManager.bones >= 40: 
		ScoreManager.bones -= 40
		GlobalValues.speed_upgrades += 1
		upgrade_happened.emit()

func setup(player_node: Node2D):
	upgrade_happened.connect(player_node._upgrade_happened)
