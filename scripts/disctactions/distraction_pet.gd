extends "res://scripts/disctactions/distraction.gd"

var timer:Timer
var scorer:Timer
var button_food:Button
var button_water:Button
var label:Label
var tex:TextureRect

var health:int
var award:float
var last_reward:float = 0
var interval = 1
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
	_calc_score(0)
	
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
	self.upgrade_level_1_title = "Amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_price = 500
	self.upgrade_level_1_price_increase = 1.55
	
	self.upgrade_level_2_title = "Multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_price = 1000
	self.upgrade_level_2_price_increase = 2
	
	self.upgrade_level_3_title = "Love"
	self.upgrade_level_3_desc = "how much you love your pet"
	self.upgrade_level_3_price = 60
	self.upgrade_level_3_price_increase = 1.225
	
	self.upgrade_level_4_title = "Torture"
	self.upgrade_level_4_desc = "hurt it to make it behave"
	self.upgrade_level_4_price = 10
	self.upgrade_level_4_price_increase = 1.115

func init() -> void:
	self.title = "pet"
	self.price = 10000
	self.amount = 1
	self.mult = 0
	last_reward = 0
	award = 0
	
	
#Amount
func upgrade_1():
	if(self.upgrade_level_1_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_1_price)
		self.upgrade_level_1_price = upgrade_level_1_price * upgrade_level_1_price_increase
		self.upgrade_level_1_level = upgrade_level_1_level + 1
		
		#upgrade
		self.amount += 1
		
#Multiplier
func upgrade_2():
	if(self.upgrade_level_2_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_2_price)
		self.upgrade_level_2_price = upgrade_level_2_price * upgrade_level_2_price_increase
		self.upgrade_level_2_level = upgrade_level_2_level + 1
		
		#upgrade
		self.mult += 0.1

#love	
func upgrade_3():
	if(self.upgrade_level_3_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_3_price)
		self.upgrade_level_3_price = upgrade_level_3_price * upgrade_level_3_price_increase
		self.upgrade_level_3_level = upgrade_level_3_level + 1
		
		#upgrade
		self.amount += 0.2

#pain
func upgrade_4():
	if(self.upgrade_level_4_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_4_price)
		self.upgrade_level_4_price = upgrade_level_4_price * upgrade_level_4_price_increase
		self.upgrade_level_4_level = upgrade_level_4_level + 1
		#upgrade
		self.amount += 0.1
		if(self.interval - 0.01 != 0):
			self.interval = self.interval - 0.01
	
func die():
	Game.remove_life()
	scorer.stop()
	print("pet timeout")

func _on_timer_timeout() -> void:
	health = health - 1
	timer.start(3)
	
	if(health <= 0):
		label.text = "dead"
		_calc_score(-2)
		die()
		timer.stop()
		scorer.stop()
	elif(health < 10):
		label.text = "dying"
		_calc_score(-1)
	elif(health < 30):
		label.text = "sick"
		_calc_score(0)
	elif(health < 60):
		label.text = "unhappy"
		_calc_score(1)
	elif(health < 80):
		label.text = "ok"
		_calc_score(2)
	elif(health < 90):
		label.text = "happy"
		_calc_score(3)
	elif(health < 101):
		label.text = "excited"
		_calc_score(4)
	elif(health < 110):
		label.text = "crazy"
		_calc_score(2)
	elif(health < 200):
		label.text = "too stuffed"
		_calc_score(0)
	elif(health < 260):
		label.text = "dead"
		_calc_score(-2)
		die()
		timer.stop()
		scorer.stop()
		
	#print(str(health))

func _calc_score(_award:float):
	last_reward = _award
	award = (_award + self.amount) * (Game.get_multiplier() + self.mult)
	#print(str(award))
	

func _on_button_food_pressed() -> void:
	health = health + 3 
	if(scorer.paused):
		scorer.start(1)


func _on_button_water_pressed() -> void:
	health = health + 1
	if(scorer.paused):
		scorer.start(1)


func _on_timer_scorer_timeout() -> void:
	_calc_score(last_reward)
	Game.add_time_points(award)
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(award,2.0,.02)
	scorer.start(self.interval)
	
	
func _on_gui_input(event: InputEvent) -> void:
	if not self.UI_MODE:
		if event is not InputEventMouseMotion:
			if event.pressed:
				Game.set_selected(self)
