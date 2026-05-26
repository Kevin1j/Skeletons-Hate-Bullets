extends Node2D

@export var environment_layer: TileMapLayer 
@export var trigger_area: Area2D
@export var enemy_spawner_scene: PackedScene
@export var item_spawner_scene: PackedScene
var spawner
var item_spawner
#next are required for the enemy_spawn node
@export var player: Character
@export var restart: Control

var target_tile: Vector2i = Vector2i(22,17)
var source_id: int = 1
#get the door states
var open_door: Vector2i = Vector2i(4,1)
var closed_door: Vector2i = Vector2i(4,3)

func _ready():
	item_spawner = item_spawner_scene.instantiate()
	add_child(item_spawner)
	
	trigger_area.body_entered.connect(_on_trigger_area_body_entered)
	restart.round_over.connect(_on_round_over)
	
func _on_trigger_area_body_entered(body):
	if body.is_in_group("player"):
		trigger_area.set_deferred("monitoring", false)
		environment_layer.set_cell(target_tile, source_id, closed_door)
		spawner = enemy_spawner_scene.instantiate()
		spawner.enemy_spawned.connect(_on_enemy_spawned)
		spawner.player = player
		spawner.restart = restart
		restart.round_over.connect(spawner.end_round)
		add_child(spawner)
		
func _on_round_over():
	if spawner != null and is_instance_valid(spawner):
		spawner.queue_free()
	environment_layer.set_cell(target_tile, source_id, open_door)
	trigger_area.set_deferred("monitoring", true)

func _on_enemy_spawned(enemy: Enemy):
	print("enemY_spawned_world_main")
	enemy.died.connect(item_spawner._on_enemy_died)
