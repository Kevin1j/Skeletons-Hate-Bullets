extends CharacterBody2D

var current_health := max_health
@export var max_health := 100
@export var movement_speed: float = 200.0
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player := get_tree().get_first_node_in_group("player")
@onready var hitbox: Area2D = $Hitbox


func _ready():
	current_health = max_health
	navigation_agent.path_desired_distance = 2
	navigation_agent.target_desired_distance = 50
	actor_setup.call_deferred()
	#Set the signal for when something enters the hitbox
	hitbox.body_entered.connect(_on_Hitbox_area_shape_entered)

func _on_Hitbox_area_shape_entered(body):
	var root = body
	while root and not root.is_in_group("bullets") and root.get_parent():
		root = root.get_parent()
	if root.is_in_group("bullets"):
		take_damage(root.damage)
		root.queue_free()
		
func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		queue_free()
		

func actor_setup():
	await get_tree().physics_frame
	if player:
		navigation_agent.target_position = player.global_position

func _physics_process(delta):
	if not player:
		return
	# Play walk animation if moving
	if velocity.length() > 1.0:
		if not $Visual/AnimatedSprite2D.is_playing():
			$Visual/AnimatedSprite2D.play("walk")
	else:
		$Visual/AnimatedSprite2D.stop()

	navigation_agent.target_position = player.global_position

	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		velocity = direction * movement_speed

		# Flip the Visual node horizontally
		if direction.x != 0:
			$Visual.scale.x = -1 if direction.x < 0 else 1
			$Hitbox/CollisionPolygon2D.scale.x = -1 if direction.x < 0 else 1

	move_and_slide()
