extends Control

func _ready() -> void:
	$TextureRect/VBoxContainer/HBoxContainer/TextureRect/AnimatedSprite2D.play("default")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/environment/main.tscn")
