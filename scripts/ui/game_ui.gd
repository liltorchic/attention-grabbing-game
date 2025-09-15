extends Panel

#pausable

func _on_button_settings_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_button_save_and_quit_pressed() -> void:
	pass # Replace with function body.
