extends Node2D

@export var environment_layer: TileMapLayer 
@export var trigger_area: Area2D
@export var enemy_spawner: PackedScene
var spawner
#next are required for the enemy_spawn node
@export var player: Character
@export var restart: Control

var target_tile: Vector2i = Vector2i(13,10)
var source_id: int = 0
#get the door states
var open_door: Vector2i = Vector2i(3,5)
var closed_door: Vector2i = Vector2i(7,1)

func _ready():
	trigger_area.body_entered.connect(_on_trigger_area_body_entered)
	restart.round_over.connect(_on_round_over)
	
func _on_trigger_area_body_entered(body):
	if body.is_in_group("player"):
		trigger_area.set_deferred("monitoring", false)
		environment_layer.set_cell(target_tile, source_id, closed_door)
		spawner = enemy_spawner.instantiate()
		spawner.player = player
		spawner.restart = restart
		add_child(spawner)
		
func _on_round_over():
	if spawner != null and is_instance_valid(spawner):
		spawner.queue_free()
	environment_layer.set_cell(target_tile, source_id, open_door)
	trigger_area.set_deferred("monitoring", true)
