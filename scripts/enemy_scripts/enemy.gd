extends CharacterBody2D
class_name enemy

@export var max_health: int = 100
var current_health: int
var is_dead = false


func _ready():
	current_health = max_health
	add_to_group("enemies")

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		die()
	
func die():
	if is_dead:
		return
	is_dead = true
	$AnimatedSprite2D.play("die")
	GlobalValues.score += 1
	await $AnimatedSprite2D.animation_finished
	queue_free()
	
