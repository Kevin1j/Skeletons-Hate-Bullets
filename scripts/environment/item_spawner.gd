extends Node2D

"""make a special item class and have this one extend that item class"""

@export var heart_drop_scene: PackedScene

func _ready():
	pass

func _on_enemy_died(enemy: Enemy, pos: Vector2):
	var heart_drop = heart_drop_scene.instantiate()
	heart_drop.global_position = pos
	add_child(heart_drop)
