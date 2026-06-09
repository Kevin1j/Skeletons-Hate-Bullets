extends Node2D

@onready var restart_prompt = preload("res://scenes/UI/screens/restart_prompt.tscn")
@export var player_node: Node2D

func _ready():
	load_game()
	player_node.player_died.connect(_on_player_died)

func _process(_delta: float): 
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused

func _on_player_died():
	save_game()
	#var restart = restart_prompt.instantiate()
	#restart.player_node = player_node
	#add_child(restart)
	pass

func save_game():
	var save_dict = {
		"bones": ScoreManager.bones,
		"high_score": ScoreManager.highscore,
		"ak_47": ScoreManager.weapons_unlocked["ak_47"],
		"deagle": ScoreManager.weapons_unlocked["deagle"],
		"ump_45": ScoreManager.weapons_unlocked["ump_45"],
		"glock18": ScoreManager.weapons_unlocked["glock18"],
	}
	
	var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	if file:
		file.store_var(save_dict)
		print("game saved")
	else:
		print("failed to save game")
	
func load_game():
	if not FileAccess.file_exists("user://savegame.dat"):
		print("No save file found")
		return
	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	if file:
		var loaded_data = file.get_var()
		ScoreManager.bones = loaded_data["bones"]
		ScoreManager.highscore = loaded_data["highscore"]
		ScoreManager.weapons_unlocked["ak_47"] = loaded_data["ak_47"]
		ScoreManager.weapons_unlocked["deagle"] = loaded_data["deagle"]
		ScoreManager.weapons_unlocked["ump_45"] = loaded_data["ump_45"]
		ScoreManager.weapons_unlocked["glock18"] = loaded_data["glock18"]
	print("game loaded successfully!")
