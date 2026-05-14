extends Character

@export var speed = 400
@onready var weapon = $AnimatedSprite2D/Ak47
@onready var player_sprite = $AnimatedSprite2D
signal player_died

func _ready():
	current_health = max_health

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	var direction_to_mouse = get_global_mouse_position() - global_position
	if weapon.flip_h == true:
		weapon.rotation = direction_to_mouse.angle()
	else:
		weapon.rotation = direction_to_mouse.angle() + PI

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	get_input()
	move_and_slide()
	if mouse_pos.x <= global_position.x:
		player_sprite.flip_h = false
		player_sprite.offset.x = 2
		#change collision shape to match
		$CollisionShape2D.position.x = -0.18
		$CollisionShape2D.position.y = -0.077
	elif mouse_pos.x >= global_position.x:
		player_sprite.flip_h = true
		player_sprite.offset.x = -2
		
		#change collision shape to match
		$CollisionShape2D.position.x = 1.1
		$CollisionShape2D.position.y = -0.077
		
	if velocity.length() > 0:
		player_sprite.play("walk")
	else:
		player_sprite.play("idle")
		

	if current_health <= 0:
		die()

func take_damage(amount):
	current_health -= amount

func die():
	player_died.emit()
	GlobalValues.dead = true
