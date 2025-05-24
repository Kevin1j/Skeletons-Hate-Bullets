extends CharacterBody2D


@export var speed = 400

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
		$AnimatedSprite2D/Ak47.flip_h = false
		$AnimatedSprite2D/Ak47/MuzzlePoint.position.x = -44
		$AnimatedSprite2D/Ak47.position.x = -0.824
		$AnimatedSprite2D/Ak47.offset.x = -10
		#change collision shape to match
		$CollisionShape2D.position.x = -0.18
		$CollisionShape2D.position.y = -0.077
	elif mouse_pos.x >= global_position.x:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D/Ak47.flip_h = true
		$AnimatedSprite2D/Ak47/MuzzlePoint.position.x = 44  
		$AnimatedSprite2D/Ak47.position.x = 4
		$AnimatedSprite2D/Ak47.offset.x = 10
		#change collision shape to match
		$CollisionShape2D.position.x = 1.1
		$CollisionShape2D.position.y = -0.077
		
		
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
