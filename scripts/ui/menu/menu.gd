extends Control

func _ready() -> void:
		($VBoxContainer/CenterContainer5/Button_delete_save as Button).disabled = not FileAccess.file_exists("user://save_json.json")
		($VBoxContainer/CenterContainer2/Button_load as Button).disabled = not FileAccess.file_exists("user://save_json.json")

func _process(delta: float) -> void:
	($VBoxContainer/CenterContainer5/Button_delete_save as Button).disabled = not FileAccess.file_exists("user://save_json.json")
	($VBoxContainer/CenterContainer2/Button_load as Button).disabled = not FileAccess.file_exists("user://save_json.json")
	
func _on_button_new_pressed() -> void:
	Game.is_new_game = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_load_pressed() -> void:
	Game.is_new_game = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_settings_pressed() -> void:
	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_delete_save_pressed() -> void:
	OS.shell_open(ProjectSettings.globalize_path("user://"))
