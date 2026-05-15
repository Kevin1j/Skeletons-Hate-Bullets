extends ProgressBar

@onready var player = $".."

func _physics_process(_delta):
	value = player.current_health
	if player.current_health != player.max_health:
		visible = true
	else: 
		visible = false
