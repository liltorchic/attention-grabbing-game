extends ColorRect

var button:Button 
var label:Label

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")


func _on_button_pressed() -> void:
	Game.add_time_point()
