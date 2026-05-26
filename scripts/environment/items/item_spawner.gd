extends Node2D

@export var heart_drop_scene: PackedScene

func _ready():
	pass

func _on_enemy_died(enemy: Enemy, pos: Vector2):
	var random = randf_range(0,1)
	if random > 0.9:
		drop_heart(pos)
	

func drop_heart(pos: Vector2):
	var heart_drop = heart_drop_scene.instantiate()
	heart_drop.global_position = pos
	add_child(heart_drop)
