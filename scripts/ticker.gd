extends ColorRect

var ticker:int
var timer:Timer
var scorer:Timer
var label:Label
var checkbutton:CheckButton
var button:Button

var isChecked

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree
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
	_on_timer_scorer_timeout()


func _on_timer_timeout() -> void:
	var increment_score = 2 if isChecked else 1
	timer.start(1)
	ticker = ticker - increment_score
	label.text = str(ticker)
	
	if(ticker <= 0):
		timer.stop()
		scorer.stop()
		_timeout()

func _on_check_button_pressed() -> void:
	isChecked = checkbutton.button_pressed
	
	var increment_score = 2 if isChecked else 1
	button.text = "+" + str(increment_score)

func _on_button_pressed() -> void:
	var increment_score = 2 if isChecked else 1
	
	ticker = ticker + increment_score
	Game.add_time_points(increment_score)	
	label.text = str(ticker)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(increment_score,2.0)
	
func _on_timer_scorer_timeout() -> void:
	var increment_score = 2 if isChecked else 1
	Game.add_time_points(increment_score)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(increment_score,2.0,.02)
	
	scorer.start(1)
	
func _timeout():
	Game.remove_life()
	print("ticker timeout")
	
