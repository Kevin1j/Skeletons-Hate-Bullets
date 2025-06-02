extends CharacterBody2D
class_name enemy

@export var max_health: int = 100
var current_health: int
var is_dead = false

func _ready():
	current_health = max_health
	$AnimatedSprite2D.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	if is_dead:
		return
	is_dead = true
	$AnimatedSprite2D.play("die")
	
func _on_animated_sprite_2d_animation_finished():
	if is_dead:
		queue_free()
