extends Node2D

@onready var restart_prompt = preload("res://scenes/UI/screens/restart_prompt.tscn")
@export var player_node: Node2D

func _ready():
	player_node.player_died.connect(_on_player_died)

func _on_player_died():
	#var restart = restart_prompt.instantiate()
	#restart.player_node = player_node
	#add_child(restart)
	pass
