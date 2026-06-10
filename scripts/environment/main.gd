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
		"highscore": ScoreManager.highscore,
		"weapons_unlocked": ScoreManager.weapons_unlocked,
		"damage_upgrades": GlobalValues.damage_upgrades,
		"fire_rate_upgrades": GlobalValues.fire_rate_upgrades,
		"speed_upgrades": GlobalValues.speed_upgrades,
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
		ScoreManager.weapons_unlocked = loaded_data["weapons_unlocked"]
		GlobalValues.damage_upgrades = loaded_data["damage_upgrades"]
		GlobalValues.fire_rate_upgrades = loaded_data["fire_rate_upgrades"]
		GlobalValues.speed_upgrades = loaded_data["speed_upgrades"]
	print("game loaded successfully!")
