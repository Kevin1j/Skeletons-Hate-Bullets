extends Node2D

var interval = .25 #seconds between enemy spawn
@export var SwordSkeleton: PackedScene 
@export var BigSkeleton: PackedScene
var spawnables


func _ready():
	randomize()
	spawn_loop()
	
func spawn_loop():
	var random_pos = 0
	var spawn
	while true:
		await get_tree().create_timer(interval).timeout
		var spawn_chance = randi_range(0,99)
		if spawn_chance < 5: #5% change to spawn big skeleton
			spawn = BigSkeleton
		elif spawn_chance < 0:
			pass #change to give other skeletons a change to spawn
		else:
			spawn = SwordSkeleton
		random_pos = Vector2(
			randf_range(318, 4275),
			randf_range(-2484, 1702))
		spawn_enemy(spawn, random_pos)

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		print("Mouse at: ", get_global_mouse_position())

func spawn_enemy(bad_guy, pos):
	#var screen_size = get_viewport_rect().size
	var skeleton = bad_guy.instantiate()
	skeleton.position = pos  
	skeleton.scale = Vector2(6.5,6.5)
	get_tree().current_scene.add_child(skeleton)
		
