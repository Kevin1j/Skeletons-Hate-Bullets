extends Sprite2D
class_name Gun

@export var bullet_scene: PackedScene 
@export var fire_rate: float = 1
@export var damage: float = 200
@export var pierce: int = 0
@onready var muzzle_point = $MuzzlePoint
@onready var player: Node2D = $"."
var is_shooting: bool = false
var cooldown: bool = false
var muzzle_x_location : int

func _physics_process(_delta):
	is_shooting = Input.is_action_pressed("shoot")
	if is_shooting && not cooldown:
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.pierce = pierce
	bullet.position = $MuzzlePoint.global_position 
	bullet.direction = (get_global_mouse_position() - player.global_position).normalized()
	get_tree().current_scene.add_child(bullet)
	cooldown = true #timer for how long between bullets
	await get_tree().create_timer(1/fire_rate).timeout
	cooldown = false #player can shoot again
	
func _process(_delta):
	#logic for the movement of the gun following the mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x <= global_position.x:
		flip_h = false
		position.x = -4.5
		muzzle_point.position.x = muzzle_x_location
	elif mouse_pos.x >= global_position.x:
		flip_h = true
		position.x = 4.5
		muzzle_point.position.x = muzzle_x_location * -1
