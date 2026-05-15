extends Area2D

@export var speed = 1200
var direction := Vector2.ZERO
@export var damage = 50
var pierce = 0
var _enemies_pierced = 0

func _process(delta):
	position += direction * speed * delta

func _ready():
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	_enemies_pierced += 1
	if _enemies_pierced == pierce:
		queue_free()
	pass
