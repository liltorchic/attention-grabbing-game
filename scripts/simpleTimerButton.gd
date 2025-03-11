extends ColorRect

var timer:Timer
var label:Label
var scorer:Timer
var timer_length:int = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	label = get_node("Label")
	scorer = get_node("Timer_Scorer")
	timer.start(timer_length)
	scorer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str("%.2f" % [timer.time_left])


func _on_timer_timeout() -> void:
	timer.stop()
	scorer.stop()
	label.text = "0.00"
	Game.remove_life()
	print("simple timer timeout")


func _on_button_pressed() -> void:
	timer.start(timer_length)
	scorer.start(1)
	


func _on_timer_scorer_timeout() -> void:
	scorer.start(1)
	Game.add_time_point()
	
