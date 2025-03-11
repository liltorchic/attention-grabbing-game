extends ColorRect

var ticker:int
var timer:Timer
var scorer:Timer
var label:Label
var checkbutton:CheckButton
var button:Button

var isChecked
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	scorer = get_node("Timer_Scorer")
	label = get_node("Label")
	button = get_node("Button")
	checkbutton = get_node("CheckButton")
	timer.start()
	scorer.start(1)
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
		scorer.stop()
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
		Game.add_time_points(2)
	else:
		ticker = ticker + 1
		Game.add_time_point()
	label.text = str(ticker)
	
func _on_timer_scorer_timeout() -> void:
	var isChecked = checkbutton.button_pressed
	if(isChecked):
		Game.add_time_points(2)
	else:
		Game.add_time_point()
	scorer.start(1)
	
func _timeout():
	Game.remove_life()
	print("ticker timeout")
	
