extends Panel
#when paused

#https://docs.godotengine.org/en/stable/classes/class_configfile.html#class-configfile

#only called when game is paused
func _process(float) -> void:
	pass

#only called when game is paused
func _input(event):
	if event.is_action_pressed("Escape"):
		_on_button_resume_pressed()

#from the pause screen
func _on_button_resume_pressed() -> void:
	hide() #hide pause screen
	get_tree().paused = false


func _on_button_quit_pressed() -> void:
	print("quiting")
	get_tree().quit()


#from the game screen
func _on_button_settings_pressed() -> void:
	show() #show pause screen
	get_tree().paused = true


func _on_button_save_and_quit_pressed() -> void:
	_saveandquit()


func _saveandquit():
	print("saving")
	Game.is_new_game = true # reset flag
	Game.save_game()
	print("quiting")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
