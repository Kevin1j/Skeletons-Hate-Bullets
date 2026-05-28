extends Node
class_name Item

@onready var pickup_range = $PickupRange

func _ready():
	add_to_group("item")
	pickup_range.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		collect(body)
	queue_free()

func collect(body: Node2D):
	pass
