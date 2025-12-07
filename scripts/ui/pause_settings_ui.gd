extends Panel
#when paused

#https://docs.godotengine.org/en/stable/classes/class_configfile.html#class-configfile
@onready var window_options: OptionButton = $VBoxContainer2/OptionButton

@onready var slider_music : HSlider = $VBoxContainer2/HBoxContainer_Music/HSlider
@onready var slider_clicks : HSlider = $VBoxContainer2/HBoxContainer_Clicks/HSlider
@onready var slider_amb : HSlider = $VBoxContainer2/HBoxContainer_Amb/HSlider
@onready var slider_sfx : HSlider = $VBoxContainer2/HBoxContainer_SFX/HSlider
@onready var slider_alarm : HSlider = $VBoxContainer2/HBoxContainer_Alarm/HSlider

var audio_music_bus = AudioServer.get_bus_index("Music")
var audio_click_bus = AudioServer.get_bus_index("Clicks")
var audio_amb_bus = AudioServer.get_bus_index("AMB")
var audio_sfx_bus = AudioServer.get_bus_index("SFX")
var audio_alarm_bus = AudioServer.get_bus_index("Alarm")


# Create new ConfigFile object.
var config = ConfigFile.new()

#only called when game is paused
func _process(float) -> void:
	pass
	
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
	
	# update bus values from config file routine
	_config()

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
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

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


func _on_option_button_item_selected(index: int) -> void:
	if(index == 2):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif(index == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_music_bus, linear_to_db(value))
	config.set_value("volume", "music", value)
	_save_config()

func _on_click_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_click_bus, linear_to_db(value))
	config.set_value("volume", "clicks", value)
	_save_config()

func _on_amb_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_amb_bus, linear_to_db(value))
	config.set_value("volume", "amb", value)
	_save_config()

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_sfx_bus, linear_to_db(value))
	config.set_value("volume", "sfx", value)
	_save_config()

func _on_alarm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_alarm_bus, linear_to_db(value))
	config.set_value("volume", "alarms", value)
	_save_config()

func _config():
	var err = config.load("user://settings.cfg")
	# If the file didn't load, ignore it.
	if err != OK:
		pass
	else:
		slider_music.value = config.get_value("volume", "music")
		slider_clicks.value = config.get_value("volume", "clicks")
		slider_amb.value = config.get_value("volume", "amb")
		slider_sfx.value = config.get_value("volume", "sfx")
		slider_alarm.value = config.get_value("volume", "alarms")
		
func _save_config():
	config.save("user://settings.cfg")
