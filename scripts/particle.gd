extends Control

var label:Label
var timer:Timer
@export var rate = 1.5
var move_dir = Vector2(randf_range(0.05,.95),randf_range(-0.05,-.95))
	
func _ready() -> void:
	timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	label = get_node("Label")
	label.text = ""
	
func emit(value: float, life:float) -> void:
	label.text = "+" + str("%.1f" % [value])
	timer.start(life)
	
func emit_speed(value: float, life:float, _rate:float) -> void:
	label.text = "+" + str("%.1f" % [value])
	rate = _rate
	timer.start(life)

func _process(_delta):
	if(label != null):
		label.position += (Vector2(randf_range(0.05,.95),randf_range(-0.05,-.95)) * rate) + move_dir

func _on_timer_timeout() -> void:
	self.queue_free()
