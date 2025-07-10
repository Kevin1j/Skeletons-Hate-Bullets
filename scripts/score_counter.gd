extends Control



#var score = get_tree().get_root().get_node("main/player/Score").get_node("ScoreCounter") #get the player score node to increase score 
func _physics_process(delta):
	$ScoreCounter.text = "Score: " + str(GlobalValues.score)
