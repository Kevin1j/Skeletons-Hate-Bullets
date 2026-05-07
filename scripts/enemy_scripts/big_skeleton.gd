extends enemy

@export var movement_speed = 350.0
@export var attack_range = 200
@onready var navigation_agent = $NavigationAgent2D
@onready var player = get_tree().get_first_node_in_group("player")
var attacking = false

func _ready():
	super._ready()
	#Calculate the initial pathfinding
	navigation_agent.target_position = player.global_position

func _physics_process(_delta):
	if is_dead:
		# Stop all movement, but DO NOT override animation
		velocity = Vector2.ZERO
		move_and_slide()
		$HitBox.monitoring = false
		$HitBox.monitorable = false
		return  # Skip everything else
	if attacking: #stop movement while attacking
		velocity = Vector2.ZERO
		move_and_slide()
		return
	# Regular enemy logic
	if velocity.length() > 1.0:
		if attacking == false:
			$AnimatedSprite2D.play("walk")
	else:
		if attacking == false:
			$AnimatedSprite2D.stop()
	navigation_agent.target_position = player.global_position
	if global_position.distance_to(player.global_position) < attack_range:
		velocity = Vector2.ZERO
		if not attacking:
			attack()
	else:
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		velocity = direction * movement_speed
		# Flip the sprite
		if direction.x != 0:
			$AnimatedSprite2D.scale.x = -1 if direction.x < 0 else 1
			$SwordHitBox.scale.x = -1 if direction.x < 0 else 1
	move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	print("yep")
	take_damage(area.damage)

func attack(): #run the skeleton attack animation and logic
	if attacking == false:
		$AnimatedSprite2D.play("attack")
	attacking = true
	$SwordHitBox.monitoring = true
	await get_tree().create_timer(0.7).timeout
	$SwordHitBox.monitoring = false
	attacking = false

func _on_sword_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(50)
	
func increase_score():
	GlobalValues.score += 5
