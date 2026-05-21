extends Control

func _ready() -> void:
	$TextureRect/VBoxContainer/HBoxContainer/TextureRect/AnimatedSprite2D.play("default")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/environment/main.tscn")



func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/title_screens/settings.tscn")



func _on_achievements_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/title_screens/achievements.tscn")


func _on_acknowledgments_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/title_screens/acknowledgments.tscn")
