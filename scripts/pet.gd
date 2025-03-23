extends ColorRect

var timer:Timer
var scorer:Timer
var button_food:Button
var button_water:Button
var label:Label
var tex:TextureRect

var health:int
var award:int

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	scorer = get_node("Timer_Scorer")
	button_food = get_node("Button_Food")
	button_water = get_node("Button_Water")
	label = get_node("Label")
	tex = get_node("TextureRect")
	label.text = "happy"
	health = 100
	scorer.start(1)
	award = 1
	_on_timer_scorer_timeout()
	
func die():
	Game.remove_life()
	scorer.stop()
	print("pet timeout")

func _on_timer_timeout() -> void:
	health = health - 1
	timer.start(3)
	
	if(health <= 0):
		label.text = "dead"
		award = 0
		die()
		timer.stop()
		scorer.stop()
	elif(health < 10):
		label.text = "dying"
		award = 0
	elif(health < 30):
		label.text = "sick"
		award = 1
	elif(health < 60):
		label.text = "unhappy"
		award = 2
	elif(health < 80):
		label.text = "ok"
		award = 2
	elif(health < 90):
		label.text = "happy"
		award = 3
	elif(health < 101):
		label.text = "excited"
		award = 4
	elif(health < 110):
		label.text = "crazy"
		award = 2
	elif(health < 200):
		label.text = "too stuffed"
		award = 1
	elif(health < 260):
		label.text = "dead"
		award = 0
		die()
		timer.stop()
		scorer.stop()
		
	print(str(health))


func _on_button_food_pressed() -> void:
	health = health + 3
	if(scorer.paused):
		scorer.start(1)


func _on_button_water_pressed() -> void:
	health = health + 1
	if(scorer.paused):
		scorer.start(1)


func _on_timer_scorer_timeout() -> void:
	Game.add_time_points(award)
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(award,2.0,.02)
	scorer.start(1)
