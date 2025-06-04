extends StaticBody2D

@onready var rotator = $Rotator
@onready var muzzle = $Rotator/MuzzlePoint
@onready var turret_sprite = $Rotator/MachineGun
var angle
var direction_index

func _process(delta):
	var to_mouse = get_global_mouse_position() - global_position
	var angle = to_mouse.angle()
	rotator.rotation = angle  # Muzzle rotation stays exact

	# Snap visual frame to quadrant
	var angle_deg = fposmod(rad_to_deg(angle) + 360.0, 360.0)
	var direction_index = 0
	if angle_deg < 45 or angle_deg >= 315:
		direction_index = 0  # Right
	elif angle_deg < 135:
		direction_index = 1  # Down
	elif angle_deg < 225:
		direction_index = 2  # Left
	else:
		direction_index = 3  # Up

	turret_sprite.frame = direction_index

	# Now rotate sprite so it visually aligns with that quadrant
	match direction_index:
		0: turret_sprite.rotation = 0
		1: turret_sprite.rotation = 3 * PI / 2  # Down
		2: turret_sprite.rotation = PI         # Left
		3: turret_sprite.rotation = PI / 2     # Up
		
