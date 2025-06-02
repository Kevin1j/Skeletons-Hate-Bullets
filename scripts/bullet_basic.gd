extends Area2D

@export var speed = 1200
var direction := Vector2.ZERO
@export var damage = 50


	
func _process(delta):
	position += direction * speed * delta
	
func _ready():
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
