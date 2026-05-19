extends Character
class_name Enemy

@export var attack_range = 80
@export var bones = 1
@export var enemy_score = 1 #How many points is the enemy worth when killed? 
@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_box = $HitBox

var is_dead = false
var is_collectible = false

signal collected

func _ready():
	super._ready()
	add_to_group("enemies")
	hit_box.body_entered.connect(_on_hit_box_body_entered)

func take_damage(amount):
	current_health -= amount
	if current_health <= 0: die()
		
func die():
	if is_dead: return
	is_dead = true
	animated_sprite.play("die")
	if not GlobalValues.dead: increase_score(enemy_score)
	await animated_sprite.animation_finished
	is_collectible = true
	for body in hit_box.get_overlapping_bodies():
		if body.is_in_group("player") and body.alive == true:
			bones_collected()
			return

func increase_score(amount):
	ScoreManager.score += amount

func _on_hit_box_body_entered(body):
	print("Something entered the hitbox: ", body.name)
	if is_collectible and body.is_in_group("player") and body.alive == true:
		bones_collected()
		
func bones_collected():
	is_collectible = false
	ScoreManager.bones += bones + randi_range(0,enemy_score)
	collected.emit()
	queue_free()
