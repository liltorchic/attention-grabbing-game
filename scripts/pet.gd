extends ColorRect

var timer:Timer
var scorer:Timer
var button_food:Button
var button_water:Button
var label:Label
var tex:TextureRect

var health:int

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
	
func die():
	Game.remove_life()
	scorer.stop()
	print("pet timeout")

func _on_timer_timeout() -> void:
	health = health - 1
	timer.start(3)
	
	if(health <= 0):
		label.text = "dead"
		die()
		timer.stop()
		scorer.stop()
	elif(health < 10):
		label.text = "dying"
	elif(health < 30):
		label.text = "sick"
	elif(health < 60):
		label.text = "unhappy"
	elif(health < 80):
		label.text = "ok"
	elif(health < 90):
		label.text = "happy"
	elif(health < 101):
		label.text = "excited"
	elif(health < 110):
		label.text = "crazy"
	elif(health < 200):
		label.text = "too stuffed"
	elif(health < 260):
		label.text = "dead"
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
	Game.add_time_point()
	scorer.start(1)
