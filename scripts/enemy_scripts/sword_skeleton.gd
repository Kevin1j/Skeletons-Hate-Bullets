extends Enemy

func _ready():
	super._ready()

func attack(): #run the skeleton attack animation and logic
	flip_sprite()
	if attacking == false:
		animated_sprite.play("attack")
	attacking = true
	$WeaponHitBox.monitoring = true
	await get_tree().create_timer(0.7).timeout
	$WeaponHitBox.monitoring = false
	attacking = false
