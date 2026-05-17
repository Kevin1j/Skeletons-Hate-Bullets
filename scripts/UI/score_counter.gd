extends CanvasLayer

func _physics_process(_delta):
	$Control/VBoxContainer/ScoreCounter.text = "Score: " + str(ScoreManager.score)
	$Control/VBoxContainer/Timer.text = "Round Time: %.2f" % ScoreManager.time
