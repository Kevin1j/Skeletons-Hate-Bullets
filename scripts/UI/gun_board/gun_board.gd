extends Node

@onready var ak_47 = $TextureRect/ak_47
@onready var deagle = $TextureRect/deagle
var gun_selected = ak_47
var guns = []

signal player_gun(gun: String)

func _ready():
	guns.append(ak_47)
	guns.append(deagle)

func _on_ak_47_pressed() -> void:
	gun_selected = ak_47
	player_gun.emit("ak_47")
	for gun in guns:
		if gun == ak_47:
			gun.button_pressed = true
		else:
			gun.button_pressed = false

func _on_deagle_pressed() -> void:
	gun_selected = deagle
	player_gun.emit("deagle")
	for gun in guns:
		if gun == deagle:
			gun.button_pressed = true
		else:
			gun.button_pressed = false
