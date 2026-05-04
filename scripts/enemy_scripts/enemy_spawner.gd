extends Node2D

@export var interval = .25 #seconds between enemy spawn
@export var SwordSkeleton: PackedScene 
@export var BigSkeleton: PackedScene

func _ready():
	randomize()
	spawn_loop()
	
func spawn_loop():
	while true:
		await get_tree().create_timer(interval).timeout
		var random_pos = Vector2(
			randf_range(318, 4275),
			randf_range(-2484, 1702))
		spawn_enemy(random_pos, SwordSkeleton, 6.5)

func _process(_delta):
	pass

func spawn_enemy(position: Vector2, enemyType: PackedScene, scale: int):
	var skelle = enemyType.instantiate()
	skelle.position = position
	skelle.scale = Vector2(scale, scale)
	get_tree().current_scene.add_child(skelle)
		
