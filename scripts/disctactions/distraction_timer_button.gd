extends "res://scripts/disctactions/distraction.gd"
var timer:Timer
var label:Label
var scorer:Timer
var button:Button
var timer_length:int = 60

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	label = get_node("Label")
	scorer = get_node("Timer_Scorer")
	button = get_node("Button")
	
	if(self.UI_MODE):
		button.disabled = true
	else:
		timer.start(timer_length)
		_on_timer_scorer_timeout()

func init() -> void:
	self.title = "timer"
	self.price = 100
	
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
	var reward = 1 * Game.get_multiplier()
	scorer.start(1)
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(reward ,1.0,.02)
	Game.add_time_points(reward)
	
	
