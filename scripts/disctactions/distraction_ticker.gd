extends "res://scripts/disctactions/distraction.gd"

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
	ticker = 10
	
	if(self.UI_MODE):
		button.disabled = true
		checkbutton.disabled = true
	else:
		timer.start()
		_on_timer_scorer_timeout()
		_on_check_button_pressed()

func init() -> void:
	self.title = "ticker"
	self.price = 5000

func _on_timer_timeout() -> void:
	var a = 2 * Game.get_multiplier() / 2.33
	var b = 1 * Game.get_multiplier() / 2.33
	var increment_score = a if isChecked else b
	timer.start(1)
	ticker = ticker - increment_score
	label.text = str(ticker)
	
	if(ticker <= 0):
		timer.stop()
		scorer.stop()
		_timeout()

func _on_check_button_pressed() -> void:
	var a = 2 * Game.get_multiplier()
	var b = 1 * Game.get_multiplier()
	isChecked = checkbutton.button_pressed
	
	var increment_score = a if isChecked else b
	button.text = "+" + str(increment_score)

func _on_button_pressed() -> void:
	var a = 2 * Game.get_multiplier()
	var b = 1 * Game.get_multiplier()
	var increment_score = a if isChecked else b
	
	ticker = ticker + increment_score
	Game.add_time_points(increment_score)	
	label.text = str(ticker)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(increment_score,2.0)
	
func _on_timer_scorer_timeout() -> void:
	var a = 2 * Game.get_multiplier()
	var b = 1 * Game.get_multiplier()
	var increment_score = a if isChecked else b
	Game.add_time_points(increment_score)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(increment_score,2.0,.02)
	
	scorer.start(1)
	
func _timeout():
	Game.remove_life()
	print("ticker timeout")
	
