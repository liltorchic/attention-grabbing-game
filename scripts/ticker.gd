extends ColorRect

var ticker:int
var timer:Timer
var label:Label
var checkbutton:CheckButton
var button:Button

var isChecked
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	label = get_node("Label")
	button = get_node("Button")
	checkbutton = get_node("CheckButton")
	timer.start()
	ticker = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var multiplier = 1
	if(isChecked):
		multiplier = 2
	timer.start(1)
	ticker = ticker - multiplier
	label.text = str(ticker)
	
	if(ticker <= 0):
		timer.stop()
		_timeout()


func _on_check_button_pressed() -> void:
	isChecked = checkbutton.button_pressed
	if(isChecked):
		button.text = "+2"
	else:
		button.text = "+1"


func _on_button_pressed() -> void:
	if(isChecked):
		ticker = ticker + 2
	else:
		ticker = ticker + 1
	label.text = str(ticker)
	
func _timeout():
	Game.remove_life()
	print("ticker timeout")
	
