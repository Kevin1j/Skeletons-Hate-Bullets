extends Node2D

#this piece of code hardcodes the player node as a child of main and assumes stand is a child of main/world_main if it errors just hate your past self
@export var player: Node2D
@onready var ui_layer = $CanvasLayer

var is_in_activate_area = false
var gun_board = preload("res://scenes/UI/gun_board.tscn")
var active_gun_board = null
signal gun_board_toggled

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_in_activate_area:
		toggle_gun_board()

func toggle_gun_board():
	gun_board_toggled.emit()
	if active_gun_board == null:
		active_gun_board = gun_board.instantiate()
		active_gun_board.equip_weapon.connect(player._equip_weapon)
		active_gun_board.z_index = 2
		ui_layer.add_child(active_gun_board)
		#active_gun_board.player_gun.connect(equip_weapon)
	else:
		active_gun_board.queue_free()
		active_gun_board = null

func _on_activate_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_activate_area = true
	pass
func _on_activate_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_activate_area = false
	pass
