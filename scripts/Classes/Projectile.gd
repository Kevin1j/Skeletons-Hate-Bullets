extends Area2D
class_name Projectile

@export var damage: int = 10
@export var initial_velocity: float = 100
@onready var velocity: Vector2 = Vector2.ZERO
var target_global_pos: Vector2
var player_direction: Vector2
var direction: Vector2
var total_distance: float
var distance_traveled: float
var arc_height: float = 50
var ground_position: Vector2
var is_grounded = false

func _ready():
	target_global_pos = target_global_pos + player_direction.normalized() * randi_range(0, 100)
	direction = (target_global_pos - global_position).normalized()
	velocity = direction * initial_velocity
	total_distance = global_position.distance_to(target_global_pos)
	arc_height = total_distance / 2
	rotation = direction.angle() + deg_to_rad(45)
	ground_position = global_position

	body_entered.connect(_on_body_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

func _physics_process(delta: float):
	if not is_grounded:
		var previous_pos = global_position
		ground_position += velocity * delta
		distance_traveled += initial_velocity * delta
		var t = distance_traveled / total_distance
		t = clamp(t, 0.0, 1.0)
		var z = arc_height * sin(t*PI)
		global_position = ground_position + Vector2(0, -z)
		#rotation logic
		var screen_movement = global_position - previous_pos
		if screen_movement.length() > 0:
			rotation = screen_movement.angle() + deg_to_rad(45)
		
		if t == 1: 
			if is_grounded == false: free_in_a_bit()
			is_grounded = true


func _on_body_entered(body):
	if body.is_in_group("player") and is_grounded == false:
		body.take_damage(damage)
		queue_free()
func _on_screen_exited():
	queue_free()
func free_in_a_bit():
	await get_tree().create_timer(5).timeout
	queue_free()
