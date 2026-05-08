extends Sprite2D
@export var player: Node2D
@export var bullet_scene: PackedScene 
var shoot = false
var cooldown = false

func _physics_process(_delta):
	"""At some point this can be abstracted to be just a general 'is shooting' thing where it can call a 
	gun scene and then just have it shooting regardless of what type of gun or upgrades the player has"""
	#Logic for determining if the player is shooting
	shoot = Input.is_action_pressed("shoot")
	if shoot == true && cooldown == false:
		var bullet = bullet_scene.instantiate()
		bullet.position = $MuzzlePoint.global_position 
		bullet.direction = (get_global_mouse_position() - player.global_position).normalized()
		get_tree().current_scene.add_child(bullet)
		cooldown = true #timer for how long between bullets
		await get_tree().create_timer(0.1).timeout
		cooldown = false #player can shoot again
	
	#logic for the movement of the gun following the mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x <= global_position.x:
		flip_h = false
		$MuzzlePoint.position.x = -44
		position.x = 0
		offset.x = -15
	elif mouse_pos.x >= global_position.x:
		flip_h = true
		$MuzzlePoint.position.x = 44  
		position.x = 0
		offset.x = 25
