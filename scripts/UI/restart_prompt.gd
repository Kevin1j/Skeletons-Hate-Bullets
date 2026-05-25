extends Control

@export var player_node: Node2D
var score_label
var high_score_label
signal round_over

func _ready():
	visible = false
	score_label = $Panel/VBoxContainer/Score
	high_score_label = $Panel/VBoxContainer/HighScore
	
	#Define Signals
	player_node.player_died.connect(_on_player_died)
	
func _on_player_died() -> void:
	stop()
	if ScoreManager.score > ScoreManager.highscore:
		ScoreManager.highscore = ScoreManager.score
	round_over.emit()
	visible = true
	score_label.text = "Score: " + str(ScoreManager.score)
	high_score_label.text = "High Score: " + str(ScoreManager.highscore)

func _on_restart_button_pressed() -> void:
	await get_tree().process_frame
	player_node.position = Vector2(700, 600)
	ScoreManager.score = 0
	GlobalValues.dead = false
	visible = false
	round_over.emit()
	player_node.alive = true
	player_node.reset_health()
	await get_tree().process_frame
	player_node.current_health = 100


func _on_menu_button_pressed() -> void:
	await get_tree().process_frame
	player_node.position = Vector2(700, 600)
	ScoreManager.score = 0
	GlobalValues.dead = false
	visible = false
	player_node.alive = true
	player_node.reset_health()
	await get_tree().process_frame
	player_node.current_health = 100
	get_tree().change_scene_to_file("res://scenes/UI/title_screens/title.tscn")
	
func stop():
	for baddie in get_tree().get_nodes_in_group("enemies"):
		baddie.queue_free()
