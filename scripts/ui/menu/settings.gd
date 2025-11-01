extends Node

@onready var window_options: OptionButton = $VBoxContainer/OptionButton

func _ready() -> void:
	if Engine.is_embedded_in_editor():
		window_options.disabled = true
		
	var current_mode = DisplayServer.window_get_mode()
	match current_mode:
		DisplayServer.WINDOW_MODE_WINDOWED:
			window_options.select(0)
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			window_options.select(1)
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			window_options.select(2)

#video window mode
func _on_option_button_item_selected(index: int) -> void:
	if(index == 2):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif(index == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	

#back button
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

#open save folder
func _on_button_savefldr_pressed() -> void:
	OS.shell_open(ProjectSettings.globalize_path("user://"))
