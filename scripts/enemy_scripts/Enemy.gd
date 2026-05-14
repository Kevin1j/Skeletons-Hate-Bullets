extends Character
class_name Enemy

@export var attack_range = 80
@onready var animated_sprite = $AnimatedSprite2D
var is_dead = false

func _ready():
	super._ready()
	add_to_group("enemies")

func take_damage(amount):
	current_health -= amount
	if current_health <= 0: die()
		
func die():
	if is_dead: return
	is_dead = true
	animated_sprite.play("die")
	if not GlobalValues.dead: increase_score()
	await animated_sprite.animation_finished
	queue_free()

func increase_score():
	"""Should try to move this function to a score tracker script and away from global for the programming challenge and clean build"""
	push_error("Method 'increase_score' must be implemented in child class.")
	#GlobalValues.score += 1
