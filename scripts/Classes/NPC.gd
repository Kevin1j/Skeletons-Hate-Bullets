extends Node
class_name NPC

#this piece of code hardcodes the player node as a child of main and assumes stand is a child of main/world_main if it errors just hate your past self
@export var player: Node2D
@onready var ui_layer = $CanvasLayer

var is_in_activate_area = false
var interact_popup = preload("res://scenes/UI/screens/interact_popup.tscn")
var active_interact_popup = null
@export var interact: PackedScene
var active_interact = null
signal interact_toggled

func _ready():
	$ActivateArea.body_entered.connect(_on_activate_area_body_entered)
	$ActivateArea.body_exited.connect(_on_activate_area_body_exited)

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_in_activate_area:
		toggle_interact()

func _on_activate_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_activate_area = true
		toggle_interact_popup(body)
	pass
func _on_activate_area_body_exited(body: Node2D) -> void:
	if active_interact != null:
		toggle_interact()
	if body.is_in_group("player"):
		is_in_activate_area = false
		toggle_interact_popup(body)
	pass

func toggle_interact():
	interact_toggled.emit()
	if active_interact == null:
		active_interact = interact.instantiate()
		active_interact.equip_weapon.connect(player._equip_weapon)
		active_interact.z_index = 2
		ui_layer.add_child(active_interact)
		#active_gun_board.player_gun.connect(equip_weapon)
	else:
		active_interact.queue_free()
		active_interact = null

func toggle_interact_popup(body: Node2D):
	if active_interact_popup == null:
		active_interact_popup = interact_popup.instantiate()
		active_interact_popup.z_index = 1
		active_interact_popup.scale = Vector2(.5,.5)
		body.add_child(active_interact_popup)
	else:
		active_interact_popup.queue_free()
		active_interact_popup = null
