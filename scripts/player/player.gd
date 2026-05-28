extends Character

@onready var weapon = $AnimatedSprite2D.get_child(0)
@onready var player_sprite = $AnimatedSprite2D
@onready var ui_layer = $CanvasLayer
var alive = true
signal player_died

var weapon_dict = {
	"ak_47": preload("res://scenes/player/weapons/ak_47.tscn"),
	"deagle": preload("res://scenes/player/weapons/deagle.tscn"),
	"ump_45": preload("res://scenes/player/weapons/ump_45.tscn")
}

func _ready():
	super()
	

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * movement_speed
	var direction_to_mouse = get_global_mouse_position() - global_position
	if weapon.flip_h == true:
		weapon.rotation = direction_to_mouse.angle()
	else:
		weapon.rotation = direction_to_mouse.angle() + PI

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
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

func _physics_process(_delta):
	#var mouse_pos = get_global_mouse_position()
	get_input()
	move_and_slide()
	
	if current_health <= 0:
		die()

func take_damage(amount):
	current_health -= amount

func die():
	alive = false
	player_died.emit()
	GlobalValues.dead = true

func _equip_weapon(weapon_name):
	if weapon:
		weapon.queue_free()
	if weapon_dict.has(weapon_name):
		var new_gun = weapon_dict[weapon_name].instantiate()
		player_sprite.add_child(new_gun)
		weapon = new_gun
		GlobalValues.weapon_equipped = weapon_name
		
		
		
		
