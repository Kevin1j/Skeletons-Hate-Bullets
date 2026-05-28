extends Node2D

var interval = 1 #seconds between enemy spawn
@export var player: Character
@export var restart: Control
@export var SwordSkeleton: PackedScene 
@export var BigSkeleton: PackedScene
@export var spawn_circle: float = 40
var spawnables

signal enemy_spawned(enemy: Enemy)

func _ready():	
	spawn_loop()
	#restart.round_over.connect(end_round)
	
func end_round():
	ScoreManager.time = 0.00
	queue_free()
	
func spawn_loop():
	var random_pos = Vector2.ZERO
	var spawn #holds the enemy that spawns
	while true:
		await get_tree().create_timer(interval).timeout
		if interval > 0:
			interval = .9 - 0.00003 * ScoreManager.time**2
		else:
			interval = 0.3
		var spawn_chance = randi_range(0,99)
		if spawn_chance < 5 + 10/(1000-ScoreManager.time): #5% change to spawn big skeleton
			spawn = BigSkeleton
		elif spawn_chance < 0:
			pass #change to give other skeletons a change to spawn
		else:
			spawn = SwordSkeleton
		var is_valid_pos = false
		var attempts = 0 #prevent an infinite while loop
		while attempts < 100:
			random_pos = Vector2(randf_range(368, 1023), randf_range(527, 176))
			var distance = random_pos.distance_to(player.global_position)
			if distance > spawn_circle:
				is_valid_pos = true
			attempts += 1
		if is_valid_pos:
			spawn_enemy(spawn, random_pos)

func _process(_delta):
	ScoreManager.time += _delta
	if Input.is_action_just_pressed("shoot"):
		print("Mouse at: ", get_global_mouse_position())

func spawn_enemy(bad_guy, pos):
	#var screen_size = get_viewport_rect().size
	var skeleton = bad_guy.instantiate()
	skeleton.position = pos  
	skeleton.scale = Vector2(1,1)
	enemy_spawned.emit(skeleton)
	get_tree().current_scene.add_child(skeleton)
