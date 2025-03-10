extends ColorRect

var timer:Timer
var label:Label
var timer_length:int = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	label = get_node("Label")
	timer.start(timer_length)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str("%.2f" % [timer.time_left])


func _on_timer_timeout() -> void:
	timer.stop()
	label.text = "0.00"
	print("simple timer timeout")


func _on_button_pressed() -> void:
	timer.start(timer_length)
	
