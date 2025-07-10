extends Control

func _ready():
	visible = false

func _on_restart_button_pressed() -> void:
	var player = get_tree().get_root().get_node("main/player")
	for skeleton in get_tree().get_nodes_in_group("enemies"):
		skeleton.queue_free()
	
	player.current_health = 100
	player.position = Vector2(2471, -478)
	visible = false
	
	pass # Replace with function body.
