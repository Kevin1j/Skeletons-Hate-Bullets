extends NPC

func _ready(): 
	super._ready()
	dialog_name = "wizard_timeline"
	dialog_signal = "open_wizard_board"
	$AnimatedSprite2D.play("idle")

func _on_activate_area_body_entered(body: Node2D) -> void:
	super._on_activate_area_body_entered(body)
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("stirring")
	
func _on_activate_area_body_exited(body: Node2D) -> void:
	super._on_activate_area_body_exited(body)
	$AnimatedSprite2D.play("idle")

func toggle_interact():
	interact_toggled.emit()
	if active_interact == null:
		active_interact = interact.instantiate()
		if active_interact.has_method("setup"):
			active_interact.setup(player)
		#active_interact.equip_weapon.connect(player._equip_weapon)
		active_interact.z_index = 2
		active_interact.size = Vector2(261, 82)
		active_interact.position = Vector2(20, -19)
		add_child(active_interact)
	else:
		active_interact.queue_free()
		active_interact = null
