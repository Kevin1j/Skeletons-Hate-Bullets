extends Control

@onready var kill_sword_skeletons = $TextureRect/ScrollContainer/VBoxContainer/Achievement0
@onready var kill_big_skeletons = $TextureRect/ScrollContainer/VBoxContainer/Achievement1

func _ready():
	if Achievements.sword_skeletons_killed >= 100: completed(kill_sword_skeletons)
	if Achievements.big_skeletons_killed >= 50: completed(kill_big_skeletons)

		

func _on_back_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/UI/title_screens/title.tscn")

func completed(rect):
	rect.get_node("CheckBox").button_pressed = true
