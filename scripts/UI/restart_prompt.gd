extends Control

@export var player_node: Node2D
var score_label
signal round_over

func _ready():
	visible = false
	score_label = $Panel/VBoxContainer/Score
	
	#Define Signals
	player_node.player_died.connect(_on_player_died)
	
func _on_player_died() -> void:
	visible = true
	score_label.text = "Score: " + str(ScoreManager.score)

func _on_restart_button_pressed() -> void:
	for baddie in get_tree().get_nodes_in_group("enemies"):
		baddie.queue_free()
	
	player_node.current_health = 100
	player_node.position = Vector2(4000, 4000)
	ScoreManager.score = 0
	GlobalValues.dead = false
	visible = false
	round_over.emit()
