extends ColorRect

var countdown_timer:Timer
var hidded_timer:Timer
var checkbox:CheckBox
var label:Label

var pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown_timer = get_node("CountdownTimer")
	hidded_timer = get_node("HiddenTimer")
	checkbox = get_node("CheckBox")
	label = get_node("Label")
	label.text = ""
	hidded_timer.start()
	pressed = checkbox.button_pressed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_countdown_timer_timeout() -> void:
	pass # Replace with function body.


func _on_hidden_timer_timeout() -> void:
	pass # Replace with function body.


func _on_check_box_pressed() -> void:
	if(checkbox.button_pressed):
		pressed 
		
