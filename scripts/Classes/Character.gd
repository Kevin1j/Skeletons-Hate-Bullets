extends CharacterBody2D
class_name Character

@export var base_movement_speed: int = 100
var movement_speed: int = 100
@export var max_health: int = 100
@export var defense: int
var current_health: int

func _ready():
	movement_speed = base_movement_speed
	current_health = max_health
	
func attack():
	pass

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		die()
func heal(amount):
	current_health += amount
	if current_health >= max_health:
		current_health = max_health
func die():
	pass

func reset_health():
	current_health = max_health
