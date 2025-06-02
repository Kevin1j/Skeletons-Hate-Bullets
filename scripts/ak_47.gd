extends Sprite2D
var shoot = false
@export var bullet_scene: PackedScene 
var cooldown = false

func get_input():
	shoot = Input.is_action_pressed("shoot")

func _physics_process(delta):
	get_input()
	if shoot == true && cooldown == false:
		var bullet = bullet_scene.instantiate()
		bullet.position = $MuzzlePoint.global_position
		var direction = (get_global_mouse_position() - bullet.position).normalized()
		bullet.direction = direction
		get_tree().current_scene.add_child(bullet)
		cooldown = true #timer for how long between bullets
		await get_tree().create_timer(0.1).timeout
		cooldown = false #player can shoot again
	
	#logic for the movement of the gun following the mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x <= global_position.x:
		flip_h = false
		$MuzzlePoint.position.x = -44
		position.x = -0.824
		offset.x = -10
	elif mouse_pos.x >= global_position.x:
		flip_h = true
		$MuzzlePoint.position.x = 44  
		position.x = 4
		offset.x = 10
