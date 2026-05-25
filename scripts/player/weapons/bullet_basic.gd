extends Area2D

@export var speed = 500
@export var damage = 50
var direction := Vector2.ZERO
var pierce = 0
var _enemies_pierced = 0
var player_velocity: Vector2 = Vector2.ZERO
var velocity_effected_bullet: int = 0

func _process(delta):
	#Original bullet calc: direction * speed * delta
	position += ((direction * speed) + (player_velocity * randi_range(0,velocity_effected_bullet))).normalized() * speed * delta  #normal ass stuff
	#position += (direction * speed + player_velocity).normalized() * speed * delta #crazy shit where every movement effects bullet movement (implement on one gun as a feature)

func _ready():
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	if _enemies_pierced > pierce:
		return
	_area.get_parent().take_damage(damage)
	_enemies_pierced += 1
	if _enemies_pierced > pierce:
		queue_free()
