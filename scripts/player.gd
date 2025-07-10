extends CharacterBody2D

@export var max_health = 100
var current_health = 100
@export var speed = 400

func _ready():
	current_health = max_health

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	var direction_to_mouse = get_global_mouse_position() - global_position
	if $AnimatedSprite2D/Ak47.flip_h == true:
		$AnimatedSprite2D/Ak47.rotation = direction_to_mouse.angle()
	else:
		$AnimatedSprite2D/Ak47.rotation = direction_to_mouse.angle() + PI

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	
	get_input()
	move_and_slide()
	if mouse_pos.x <= global_position.x:
		$AnimatedSprite2D.flip_h = false
		
		#change collision shape to match
		$CollisionShape2D.position.x = -0.18
		$CollisionShape2D.position.y = -0.077
	elif mouse_pos.x >= global_position.x:
		$AnimatedSprite2D.flip_h = true
		
		#change collision shape to match
		$CollisionShape2D.position.x = 1.1
		$CollisionShape2D.position.y = -0.077
		
		
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
		
	if current_health != max_health:
		$HealthBar.visible = true
	else: 
		$HealthBar.visible = false
	if current_health <= 0:
		#Implement game over UI
		$GameOver.visible = true
		pass
		


func take_damage(amount):
	current_health -= amount
	$HealthBar.value = current_health
