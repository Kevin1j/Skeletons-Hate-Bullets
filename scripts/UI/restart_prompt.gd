extends Control

@export var player_node: Node2D
var score_label

func _ready():
	visible = false
	player_node.player_died.connect(_on_player_died)
	score_label = $Panel/VBoxContainer/Score
	
func _on_player_died() -> void:
	visible = true
	score_label.text = "Score: " + str(GlobalValues.score)

func _on_restart_button_pressed() -> void:
	print("yes")
	for baddie in get_tree().get_nodes_in_group("enemies"):
		baddie.queue_free()
	
	player_node.current_health = 100
	player_node.position = Vector2(2471, -478)
	GlobalValues.score = 0
	GlobalValues.dead = false
	visible = false
