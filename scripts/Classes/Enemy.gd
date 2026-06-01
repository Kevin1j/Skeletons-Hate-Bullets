extends Character
class_name Enemy

@export var attack_range = 80
@export var damage = 10
@export var bones = 1
@export var enemy_type: String
@export var enemy_score = 1 #How many points is the enemy worth when killed? 
@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_box = $HitBox
@onready var weapon_hit_box = $WeaponHitBox
@onready var collision_box = $CollisionBox
@onready var navigation_agent = $NavigationAgent2D
@onready var attacking = false

@onready var player = get_tree().get_first_node_in_group("player")

var is_dead = false
var is_collectible = false
var direction

signal collected
signal died(enemy_type: String, enemy_position: Vector2)

func _ready():
	max_health += 0.2*ScoreManager.time
	super._ready()
	add_to_group("enemies")
	hit_box.body_entered.connect(_on_hit_box_body_entered)
	weapon_hit_box.body_entered.connect(_on_weapon_hit_box_body_entered)

func _physics_process(_delta):
	if is_dead:
		# Stop all movement, but DO NOT override animation
		velocity = Vector2.ZERO
		move_and_slide()
		$HitBox.monitorable = false
		return  # Skip everything else
	if attacking: #stop movement while attacking
		velocity = Vector2.ZERO
		move_and_slide()
		return
	# Regular enemy logic
	if velocity.length() > 1.0:
		if attacking == false:
			animated_sprite.play("walk")
	else:
		if attacking == false:
			animated_sprite.stop()
	navigation_agent.target_position = player.global_position
	if global_position.distance_to(player.global_position) < attack_range:
		velocity = Vector2.ZERO
		if not attacking:
			attack()
	else:
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		direction = global_position.direction_to(next_path_position)
		velocity = direction * movement_speed
		if direction.x != 0:
			flip_sprite()
	move_and_slide()
func flip_sprite():
	# Flip the sprite
	animated_sprite.scale.x = -1 if player.global_position.x-global_position.x < 0 else 1
	$WeaponHitBox.scale.x = -1 if player.global_position.x-global_position.x < 0 else 1
	

func take_damage(amount):
	current_health -= amount
	if current_health <= 0: die()
	scale = Vector2(0.8, 1.2)
	await get_tree().create_timer(0.1).timeout
	scale = Vector2(1,1)
		
func die():
	var current_kills = Achievements.get(enemy_type + "s_killed")
	Achievements.set(enemy_type + "s_killed", current_kills + 1)
	if is_dead: return
	is_dead = true
	died.emit(self, global_position)
	collision_box.queue_free()
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
	if is_collectible and body.is_in_group("player") and body.alive == true:
		bones_collected()
func _on_weapon_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		
func bones_collected():
	is_collectible = false
	ScoreManager.bones += bones + randi_range(0,enemy_score)
	collected.emit()
	queue_free()
