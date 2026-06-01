extends Enemy

var arrow_scene = preload("res://scenes/enemy_scenes/enemy_weapons/arrow.tscn")

func _ready():
	super._ready()

func attack(): #run the skeleton attack animation and logic
	flip_sprite()
	if attacking == false:
		animated_sprite.play("attack")
	attacking = true
	spawn_arrow()
	await get_tree().create_timer(1).timeout
	"""
	$WeaponHitBox.monitoring = true
	await get_tree().create_timer(0.7).timeout
	$WeaponHitBox.monitoring = false
	"""
	attacking = false

func spawn_arrow():
	var arrow = arrow_scene.instantiate()
	arrow.global_position = global_position
	arrow.target_global_pos = player.global_position
	arrow.player_direction = player.velocity
	get_tree().current_scene.add_child(arrow)
	
