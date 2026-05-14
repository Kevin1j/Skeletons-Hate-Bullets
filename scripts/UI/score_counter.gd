extends Control

func _physics_process(_delta):
	$ScoreCounter.text = "Score: " + str(ScoreManager.score)
