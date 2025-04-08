extends "res://scripts/disctactions/distraction.gd"

var timer:Timer
var scorer:Timer
var button_food:Button
var button_water:Button
var label:Label
var tex:TextureRect

var health:int
var award:int

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
	award = 1 * Game.get_multiplier()
	
	init()
	
	if(self.UI_MODE):
		button_food.disabled = true	
		button_water.disabled = true	
	else:
		timer.start(3)
		_on_timer_scorer_timeout()
				#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.update_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func update_upgrade_data():
	self.upgrade_level_1_title = "amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_startingprice = 10000
	self.upgrade_level_1_type = Constants.Type.AMOUNT
	
	self.upgrade_level_2_title = "multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_startingprice = 1000
	self.upgrade_level_2_type = Constants.Type.MULTIPLIER
	
	self.upgrade_level_3_title = "love"
	self.upgrade_level_3_desc = "how much you love your pet"
	self.upgrade_level_3_startingprice = 10000
	self.upgrade_level_3_type = Constants.Type.LOVE
	
	self.upgrade_level_4_title = "torture"
	self.upgrade_level_4_desc = "hurt it to make it behave"
	self.upgrade_level_4_startingprice = 0.1
	self.upgrade_level_4_type = Constants.Type.TORTURE

func init() -> void:
	self.title = "pet"
	self.price = 10000
	
func update_labels():
	pass
	
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
		award = 0 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 30):
		label.text = "sick"
		award = 2 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 60):
		label.text = "unhappy"
		award = 2 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 80):
		label.text = "ok"
		award = 2 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 90):
		label.text = "happy"
		award = 3 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 101):
		label.text = "excited"
		award = 4 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 110):
		label.text = "crazy"
		award = 2 + self.amount * Game.get_multiplier() + self.mult
	elif(health < 200):
		label.text = "too stuffed"
		award = 1 + self.amount * Game.get_multiplier() + self.mult
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
	timer.start(3)
	
	
