extends Panel

#when paused


#only called when game is paused
func _process(float) -> void:
	pass


#from the pause screen
func _on_button_resume_pressed() -> void:
	hide() #hide pause screen
	get_tree().paused = false


func _on_button_quit_pressed() -> void:
	pass # Replace with function body.





#from the game screen
func _on_button_settings_pressed() -> void:
	show() #show pause screen
	get_tree().paused = true
