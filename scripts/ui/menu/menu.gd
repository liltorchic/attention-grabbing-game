extends Control


func _on_button_new_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_load_pressed() -> void:
	pass # Replace with function body.


func _on_button_settings_pressed() -> void:
	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit()
