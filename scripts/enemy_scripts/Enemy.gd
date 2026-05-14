extends Character
class_name Enemy

@export var attack_range = 80
@onready var animated_sprite = $AnimatedSprite2D
var enemy_score = 1 #How many points is the enemy worth when killed? 
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
	if not GlobalValues.dead: increase_score(enemy_score)
	await animated_sprite.animation_finished
	queue_free()

func increase_score(amount):
	ScoreManager.score += amount
