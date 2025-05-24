extends StaticBody2D

@export var speed = 800
var direction := Vector2.ZERO

func _process(delta):
	position += direction * speed * delta
	
func _ready():
	await get_tree().create_timer(3.0).timeout  # 2 seconds
	queue_free()
