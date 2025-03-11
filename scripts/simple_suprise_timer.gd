extends ColorRect

var countdown_timer:Timer
var hidden_timer:Timer
var scorer:Timer
var label:Label
var button:Button

var rng = RandomNumberGenerator.new()

var timer_hidden:bool
var timer_amount:int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown_timer = get_node("TimerCountdown")
	hidden_timer = get_node("TimerHidden")
	scorer = get_node("Timer_Scorer")
	label = get_node("Label")
	button = get_node("Button")
	label.text = ""
	timer_hidden = true
	button.visible = false
	countdown_timer.set_wait_time(timer_amount + 0.01) # +0.01 so the scorewr can score on 0.00
	hidden_timer.start(rng.randf_range(6, 12))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!timer_hidden):
		label.text =  str("%.2f" % [countdown_timer.time_left])
	


func _on_timer_hidden_timeout() -> void:
	timer_hidden = false
	button.visible = true
	countdown_timer.start()
	scorer.start(1)


#you lose
func _on_timer_countdown_timeout() -> void:
	countdown_timer.stop()
	hidden_timer.stop()
	scorer.stop()
	label.text = "0.00"
	Game.remove_life()
	print("suprise defuse timeout")


func _on_button_pressed() -> void:
	timer_hidden = true
	label.text = ""
	countdown_timer.stop()
	scorer.start(1)
	countdown_timer.set_wait_time(timer_amount)
	hidden_timer.start(rng.randf_range(6, 12))
	button.visible = false
	
func _on_timer_scorer_timeout() -> void:
	scorer.start(1)
	Game.add_time_points(20)
