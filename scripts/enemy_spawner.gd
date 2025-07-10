extends Node2D

var interval = .25 #seconds between enemy spawn
@export var SwordSkeleton: PackedScene 


func _ready():
	randomize()
	spawn_loop()
	
func spawn_loop():
	while true:
		await get_tree().create_timer(interval).timeout
		spawn_enemy()

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		print("Mouse at: ", get_global_mouse_position())

func spawn_enemy():
	var screen_size = get_viewport_rect().size
	var random_pos = Vector2(
			randf_range(318, 4275),
			randf_range(-2484, 1702))
	var sword = SwordSkeleton.instantiate()
	sword.position = random_pos  
	sword.scale = Vector2(6.5,6.5)
	get_tree().current_scene.add_child(sword)
		
