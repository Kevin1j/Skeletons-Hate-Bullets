extends Sprite2D
class_name Gun

@export var bullet_scene: PackedScene 
@export var fire_rate: float = 1
@export var damage: float = 200
@export var pierce: int = 0
@export var gun_position: float = 0
@export var velocity_effected_bullet: int = 0 #whether or not the bullet is affected by the players movement
@onready var muzzle_point = $MuzzlePoint
@onready var player_sprite = get_parent()
@onready var player: Node2D = $".".get_parent().get_parent()
var is_shooting: bool = false
var cooldown: bool = false
var muzzle_x_location : int
var gun_board_open = false

func _ready():
	player.gun_board_toggled.connect(_on_gun_board_toggled)
	pass

func _physics_process(_delta):
	is_shooting = Input.is_action_pressed("shoot")
	if is_shooting && not cooldown && not gun_board_open:
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.player_velocity = player.velocity
	bullet.damage = damage
	bullet.pierce = pierce
	bullet.velocity_effected_bullet = velocity_effected_bullet
	bullet.position = $MuzzlePoint.global_position 
	bullet.direction = (get_global_mouse_position() - player.global_position).normalized()
	get_tree().current_scene.add_child(bullet)
	cooldown = true #timer for how long between bullets
	await get_tree().create_timer(1/fire_rate).timeout
	cooldown = false #player can shoot again
	
func _process(_delta):
	#logic for the movement of the gun following the mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x <= player_sprite.global_position.x:
		flip_h = false
		position.x = -gun_position
		muzzle_point.position.x = muzzle_x_location
	elif mouse_pos.x >= player_sprite.global_position.x:
		flip_h = true
		position.x = gun_position
		muzzle_point.position.x = muzzle_x_location * -1
func _on_gun_board_toggled():
	if gun_board_open == true:
		gun_board_open = false
	else:
		gun_board_open = true
